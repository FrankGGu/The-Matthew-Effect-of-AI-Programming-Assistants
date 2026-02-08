#include <stdlib.h>
#include <string.h>

typedef struct {
    char* from;
    char* to;
    int used;
} Ticket;

typedef struct {
    char** itinerary;
    int size;
    int capacity;
} Result;

int compareTickets(const void* a, const void* b) {
    Ticket* t1 = (Ticket*)a;
    Ticket* t2 = (Ticket*)b;
    int cmp = strcmp(t1->from, t2->from);
    if (cmp != 0) return cmp;
    return strcmp(t1->to, t2->to);
}

int dfs(char* current, Ticket* tickets, int ticketsSize, Result* result, int usedCount) {
    if (usedCount == ticketsSize) {
        return 1;
    }

    for (int i = 0; i < ticketsSize; i++) {
        if (tickets[i].used || strcmp(tickets[i].from, current) != 0) {
            continue;
        }

        tickets[i].used = 1;
        if (result->size >= result->capacity - 1) {
            result->capacity *= 2;
            result->itinerary = realloc(result->itinerary, result->capacity * sizeof(char*));
        }
        result->itinerary[result->size++] = tickets[i].to;

        if (dfs(tickets[i].to, tickets, ticketsSize, result, usedCount + 1)) {
            return 1;
        }

        result->size--;
        tickets[i].used = 0;
    }

    return 0;
}

char** findItinerary(char*** tickets, int ticketsSize, int* ticketsColSize, int* returnSize) {
    Ticket* ticketList = malloc(ticketsSize * sizeof(Ticket));
    for (int i = 0; i < ticketsSize; i++) {
        ticketList[i].from = tickets[i][0];
        ticketList[i].to = tickets[i][1];
        ticketList[i].used = 0;
    }

    qsort(ticketList, ticketsSize, sizeof(Ticket), compareTickets);

    Result result;
    result.capacity = 16;
    result.size = 0;
    result.itinerary = malloc(result.capacity * sizeof(char*));
    result.itinerary[result.size++] = "JFK";

    dfs("JFK", ticketList, ticketsSize, &result, 0);

    free(ticketList);

    *returnSize = result.size;
    return result.itinerary;
}