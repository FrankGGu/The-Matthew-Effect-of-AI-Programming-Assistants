#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_TICKETS 300
#define MAX_AIRPORT_LEN 4

typedef struct {
    char from[MAX_AIRPORT_LEN];
    char to[MAX_AIRPORT_LEN];
    int used;
} Ticket;

int compare_tickets(const void *a, const void *b) {
    const Ticket *ticket1 = (const Ticket *)a;
    const Ticket *ticket2 = (const Ticket *)b;
    int from_cmp = strcmp(ticket1->from, ticket2->from);
    if (from_cmp != 0) {
        return from_cmp;
    }
    return strcmp(ticket1->to, ticket2->to);
}

int find_itinerary(Ticket *tickets, int num_tickets, char *current_airport, char **result, int result_index) {
    result[result_index] = current_airport;

    if (result_index == num_tickets) {
        return 1; 
    }

    for (int i = 0; i < num_tickets; i++) {
        if (strcmp(tickets[i].from, current_airport) == 0 && !tickets[i].used) {
            tickets[i].used = 1;
            if (find_itinerary(tickets, num_tickets, tickets[i].to, result, result_index + 1)) {
                return 1;
            }
            tickets[i].used = 0;
        }
    }

    return 0;
}

char ** findItinerary(char *** tickets, int ticketsSize, int* ticketsColSize, int* returnSize){
    Ticket ticket_array[MAX_TICKETS];
    for (int i = 0; i < ticketsSize; i++) {
        strcpy(ticket_array[i].from, tickets[i][0]);
        strcpy(ticket_array[i].to, tickets[i][1]);
        ticket_array[i].used = 0;
    }

    qsort(ticket_array, ticketsSize, sizeof(Ticket), compare_tickets);

    char **result = (char **)malloc((ticketsSize + 1) * sizeof(char *));
    for (int i = 0; i < ticketsSize + 1; i++) {
        result[i] = (char *)malloc(MAX_AIRPORT_LEN * sizeof(char));
    }

    find_itinerary(ticket_array, ticketsSize, "JFK", result, 0);

    *returnSize = ticketsSize + 1;
    return result;
}