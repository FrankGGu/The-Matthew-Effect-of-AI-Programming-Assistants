#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // Required for memset if used, but cleanup_stop_routes_map handles initialization

typedef struct StopRoutesEntry {
    int stop_id;
    int* route_indices; // Dynamically allocated array of route indices
    int count;          // Number of routes for this stop
    int capacity;       // Capacity of route_indices array
    struct StopRoutesEntry* next; // For chaining in case of hash collisions
} StopRoutesEntry;

#define HASH_TABLE_SIZE 100003 

StopRoutesEntry* stop_routes_map[HASH_TABLE_SIZE];

unsigned int hash_func(int stop_id) {
    return (unsigned int)stop_id % HASH_TABLE_SIZE;
}

void add_route_to_stop(int stop_id, int route_idx) {
    unsigned int hash_val = hash_func(stop_id);
    StopRoutesEntry* entry = stop_routes_map[hash_val];

    // Search for an existing entry for this stop_id in the linked list
    while (entry != NULL && entry->stop_id != stop_id) {
        entry = entry->next;
    }

    if (entry == NULL) {
        // If no entry exists, create a new one
        entry = (StopRoutesEntry*)malloc(sizeof(StopRoutesEntry));
        entry->stop_id = stop_id;
        entry->route_indices = (int*)malloc(sizeof(int) * 4); // Initial capacity
        entry->count = 0;
        entry->capacity = 4;
        entry->next = stop_routes_map[hash_val]; // Add to the front of the linked list
        stop_routes_map[hash_val] = entry;
    }

    // Add the route_idx to the entry's dynamic array
    if (entry->count == entry->capacity) {
        entry->capacity *= 2; // Double capacity
        entry->route_indices = (int*)realloc(entry->route_indices, sizeof(int) * entry->capacity);
    }
    entry->route_indices[entry->count++] = route_idx;
}

StopRoutesEntry* get_stop_routes_entry(int stop_id) {
    unsigned int hash_val = hash_func(stop_id);
    StopRoutesEntry* entry = stop_routes_map[hash_val];
    while (entry != NULL && entry->stop_id != stop_id) {
        entry = entry->next;
    }
    return entry;
}

void cleanup_stop_routes_map() {
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        StopRoutesEntry* entry = stop_routes_map[i];
        while (entry != NULL) {
            StopRoutesEntry* temp = entry;
            entry = entry->next;
            free(temp->route_indices); // Free the dynamic array of route indices
            free(temp); // Free the StopRoutesEntry node itself
        }
        stop_routes_map[i] = NULL; // Reset the hash table bucket pointer
    }
}

int numBusesToDestination(int** routes, int routesSize, int* routesColSize, int source, int target) {
    // If source and target are the same, no buses are needed.
    if (source == target) {
        return 0;
    }

    // Clean up the hash map from previous calls, if any, before populating it.
    cleanup_stop_routes_map();

    // Populate the stop_to_routes hash map.
    // For each route, iterate through its stops and record which routes pass through each stop.
    for (int i = 0; i < routesSize; ++i) {
        for (int j = 0; j < routesColSize[i]; ++j) {
            add_route_to_stop(routes[i][j], i);
        }
    }

    // BFS setup
    // Queue stores route indices. Max routesSize is 500.
    int* queue = (int*)malloc(sizeof(int) * routesSize);
    int head = 0, tail = 0; // Pointers for the circular queue

    // visited_routes tracks which routes have been added to the queue to avoid cycles and redundant processing.
    // Initialized to false using calloc.
    bool* visited_routes = (bool*)calloc(routesSize, sizeof(bool)); 

    int bus_changes = 0; // Counts the number of bus changes (levels in BFS)

    // Find all routes that contain the source stop and add them to the queue.
    StopRoutesEntry* source_routes_entry = get_stop_routes_entry(source);
    if (source_routes_entry == NULL) {
        // If the source stop is not on any route, it's impossible to start.
        free(queue);
        free(visited_routes);
        cleanup_stop_routes_map();
        return -1;
    }

    for (int i = 0; i < source_routes_entry->count; ++i) {
        int route_idx = source_routes_entry->route_indices[i];
        if (!visited_routes[route_idx]) {
            queue[tail++] = route_idx;
            visited_routes[route_idx] = true;
        }
    }

    // Perform BFS
    while (head != tail) {
        int level_size = tail - head; // Number of routes at the current BFS level

        for (int i = 0; i < level_size; ++i) {
            int current_route_idx = queue[head++]; // Dequeue a route

            // Check all stops on the current route
            for (int j = 0; j < routesColSize[current_route_idx]; ++j) {
                int stop = routes[current_route_idx][j];

                // If the target stop is found on the current route, we've reached the destination.
                // The number of buses taken is bus_changes + 1 (current route is the last bus).
                if (stop == target) {
                    free(queue);
                    free(visited_routes);
                    cleanup_stop_routes_map();
                    return bus_changes + 1;
                }

                // Explore other routes reachable from this stop
                StopRoutesEntry* connected_routes_entry = get_stop_routes_entry(stop);
                if (connected_routes_entry != NULL) {
                    for (int k = 0; k < connected_routes_entry->count; ++k) {
                        int next_route_idx = connected_routes_entry->route_indices[k];
                        if (!visited_routes[next_route_idx]) {
                            visited_routes[next_route_idx] = true;
                            queue[tail++] = next_route_idx; // Enqueue the new route
                        }
                    }
                }
            }
        }
        bus_changes++; // Increment bus changes after processing all routes at the current level
    }

    // If the BFS completes and the target stop was not reached, it's impossible.
    free(queue);
    free(visited_routes);
    cleanup_stop_routes_map();
    return -1;
}