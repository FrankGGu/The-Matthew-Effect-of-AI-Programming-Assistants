#include <stdlib.h> // For malloc, free, qsort, bsearch
#include <string.h> // For strcmp, strcpy
#include <stdbool.h> // For bool type

typedef struct {
    char name[4];
    int id;
} AirportMapEntry;

int compareAirportMapEntries(const void *a, const void *b) {
    return strcmp(((AirportMapEntry *)a)->name, ((AirportMapEntry *)b)->name);
}

int searchAirportMapEntries(const void *key, const void *elem) {
    return strcmp((char *)key, ((AirportMapEntry *)elem)->name);
}

typedef struct {
    int dest_id;
    bool used; // To mark if this specific edge has been used
} Edge;

typedef struct {
    Edge *edges;
    int count;      // Current number of edges
    int capacity;   // Allocated capacity for edges
} AdjList;

AdjList *g_adj;
int g_numUniqueAirports;
char **g_airportNames; // Maps int ID back to char* name
int g_numTickets;
char **g_result;       // Stores the final itinerary
int g_resultIdx;      // Current index in g_result
int g_targetLen;      // Number of airports in the itinerary (numTickets + 1)
bool g_found;         // Flag to stop DFS once a valid itinerary is found

void dfs(int currentAirportId) {
    if (g_found) {
        return;
    }

    // Add current airport name to the result path
    g_result[g_resultIdx] = (char*)malloc(sizeof(char) * 4);
    strcpy(g_result[g_resultIdx], g_airportNames[currentAirportId]);
    g_resultIdx++;

    // If we have collected all required airports (numTickets + 1), a path is found
    if (g_resultIdx == g_targetLen) {
        g_found = true;
        return;
    }

    // Iterate through edges from currentAirportId
    // Edges are sorted by destination ID, ensuring lexical order preference
    for (int i = 0; i < g_adj[currentAirportId].count; ++i) {
        if (!g_adj[currentAirportId].edges[i].used) {
            g_adj[currentAirportId].edges[i].used = true; // Mark edge as used
            dfs(g_adj[currentAirportId].edges[i].dest_id);
            if (g_found) {
                return; // Path found, propagate up
            }
            g_adj[currentAirportId].edges[i].used = false; // Backtrack: mark edge as unused
        }
    }

    // If no path found from currentAirportId using remaining tickets, backtrack
    g_resultIdx--;
    free(g_result[g_resultIdx]); // Free the copied string for the current airport
}

int compareEdges(const void *a, const void *b) {
    return ((Edge *)a)->dest_id - ((Edge *)b)->dest_id;
}

char ** findItinerary(char *** tickets, int ticketsSize, int* returnSize) {
    g_numTickets = ticketsSize;
    g_targetLen = ticketsSize + 1;
    g_found = false;
    g_resultIdx = 0;

    // --- Step 1: Collect all unique airport names and map them to integer IDs ---
    // Max possible unique airports = 2 * ticketsSize (each ticket has src & dest)
    AirportMapEntry *uniqueAirports = (AirportMapEntry*)malloc(sizeof(AirportMapEntry) * (2 * ticketsSize));
    int uniqueCount = 0;

    // Use a temporary array to store all airport names from tickets
    char (*tempAirportNames)[4] = (char(*)[4])malloc(sizeof(char) * 4 * (2 * ticketsSize));
    int tempAirportCount = 0;

    for (int i = 0; i < ticketsSize; ++i) {
        strcpy(tempAirportNames[tempAirportCount++], tickets[i][0]);
        strcpy(tempAirportNames[tempAirportCount++], tickets[i][1]);
    }

    // Sort the temporary airport names to find unique ones
    qsort(tempAirportNames, tempAirportCount, sizeof(char) * 4, (int(*)(const void*, const void*))strcmp);

    // Populate uniqueAirports array
    if (tempAirportCount > 0) {
        strcpy(uniqueAirports[uniqueCount].name, tempAirportNames[0]);
        uniqueAirports[uniqueCount].id = uniqueCount;
        uniqueCount++;
        for (int i = 1; i < tempAirportCount; ++i) {
            if (strcmp(tempAirportNames[i], uniqueAirports[uniqueCount-1].name) != 0) {
                strcpy(uniqueAirports[uniqueCount].name, tempAirportNames[i]);
                uniqueAirports[uniqueCount].id = uniqueCount;
                uniqueCount++;
            }
        }
    }
    g_numUniqueAirports = uniqueCount;
    free(tempAirportNames); // Free temporary array

    // Create g_airportNames (ID -> name) mapping
    g_airportNames = (char**)malloc(sizeof(char*) * g_numUniqueAirports);
    for (int i = 0; i < g_numUniqueAirports; ++i) {
        g_airportNames[i] = (char*)malloc(sizeof(char) * 4);
        strcpy(g_airportNames[i], uniqueAirports[i].name);
    }

    // Find JFK's ID
    int jfk_id = -1;
    AirportMapEntry *jfk_entry = (AirportMapEntry*)bsearch("JFK", uniqueAirports, g_numUniqueAirports, sizeof(AirportMapEntry), searchAirportMapEntries);
    if (jfk_entry) {
        jfk_id = jfk_entry->id;
    } else {
        // According to problem, "JFK" is always the starting point, so it must exist.
        // This branch should ideally not be reached.
    }

    // --- Step 2: Build Adjacency List ---
    g_adj = (AdjList*)calloc(g_numUniqueAirports, sizeof(AdjList)); // Initialize with zeros

    // First pass to count edges for each source airport
    for (int i = 0; i < ticketsSize; ++i) {
        AirportMapEntry *src_entry = (AirportMapEntry*)bsearch(tickets[i][0], uniqueAirports, g_numUniqueAirports, sizeof(AirportMapEntry), searchAirportMapEntries);
        g_adj[src_entry->id].count++; // Temporarily use count to store total edges for this source
    }

    // Allocate memory for edges for each source airport
    for (int i = 0; i < g_numUniqueAirports; ++i) {
        if (g_adj[i].count > 0) {
            g_adj[i].edges = (Edge*)malloc(sizeof(Edge) * g_adj[i].count);
            g_adj[i].capacity = g_adj[i].count; // Store original count as capacity
            g_adj[i].count = 0; // Reset count for actual population of edges
        }
    }

    // Second pass to populate edges
    for (int i = 0; i < ticketsSize; ++i) {
        AirportMapEntry *src_entry = (AirportMapEntry*)bsearch(tickets[i][0], uniqueAirports, g_numUniqueAirports, sizeof(AirportMapEntry), searchAirportMapEntries);
        AirportMapEntry *dest_entry = (AirportMapEntry*)bsearch(tickets[i][1], uniqueAirports, g_numUniqueAirports, sizeof(AirportMapEntry), searchAirportMapEntries);

        int src_id = src_entry->id;
        g_adj[src_id].edges[g_adj[src_id].count].dest_id = dest_entry->id;
        g_adj[src_id].edges[g_adj[src_id].count].used = false;
        g_adj[src_id].count++;
    }

    // Sort edges for each source airport by destination ID for lexical order
    for (int i = 0; i < g_numUniqueAirports; ++i) {
        if (g_adj[i].count > 0) {
            qsort(g_adj[i].edges, g_adj[i].count, sizeof(Edge), compareEdges);
        }
    }

    // Free uniqueAirports as it's no longer needed
    free(uniqueAirports);
    uniqueAirports = NULL;

    // --- Step 3: Perform DFS to find the itinerary ---
    g_result = (char**)malloc(sizeof(char*) * g_targetLen);
    dfs(jfk_id);

    // --- Step 4: Cleanup and return ---
    *returnSize = g_targetLen;

    // Free all dynamically allocated memory for graph structures
    for (int i = 0; i < g_numUniqueAirports; ++i) {
        if (g_adj[i].edges) {
            free(g_adj[i].edges);
        }
        free(g_airportNames[i]);
    }
    free(g_adj);
    free(g_airportNames);
    g_adj = NULL;
    g_airportNames = NULL;

    return g_result; // The caller (LeetCode test harness) is responsible for freeing g_result and its string contents.
}