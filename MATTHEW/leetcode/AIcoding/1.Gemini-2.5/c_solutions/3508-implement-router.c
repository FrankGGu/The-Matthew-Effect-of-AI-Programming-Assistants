#include <stdlib.h> // For malloc, free, abs

#define HASH_TABLE_SIZE 100 // A reasonable size for a simple hash table

typedef struct RouteEntry {
    int destination_ip; // Simplified IP address as an integer
    int next_hop_ip;    // Simplified IP address as an integer
    int cost;           // Metric/cost of the route
    struct RouteEntry* next; // Pointer for chaining in hash table buckets
} RouteEntry;

typedef struct {
    RouteEntry* buckets[HASH_TABLE_SIZE]; // Array of pointers to linked lists (hash table)
} Router;

static int hash(int ip) {
    return abs(ip) % HASH_TABLE_SIZE;
}

Router* routerCreate() {
    Router* router = (Router*)malloc(sizeof(Router));
    if (router == NULL) {
        return NULL;
    }
    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        router->buckets[i] = NULL;
    }
    return router;
}

void routerAddRoute(Router* router, int destination_ip, int next_hop_ip, int cost) {
    if (router == NULL) return;

    int index = hash(destination_ip);
    RouteEntry* current = router->buckets[index];
    RouteEntry* prev = NULL;

    while (current != NULL) {
        if (current->destination_ip == destination_ip) {
            current->next_hop_ip = next_hop_ip;
            current->cost = cost;
            return;
        }
        prev = current;
        current = current->next;
    }

    RouteEntry* newEntry = (RouteEntry*)malloc(sizeof(RouteEntry));
    if (newEntry == NULL) {
        return;
    }
    newEntry->destination_ip = destination_ip;
    newEntry->next_hop_ip = next_hop_ip;
    newEntry->cost = cost;
    newEntry->next = NULL;

    if (prev == NULL) {
        router->buckets[index] = newEntry;
    } else {
        prev->next = newEntry;
    }
}

void routerRemoveRoute(Router* router, int destination_ip) {
    if (router == NULL) return;

    int index = hash(destination_ip);
    RouteEntry* current = router->buckets[index];
    RouteEntry* prev = NULL;

    while (current != NULL) {
        if (current->destination_ip == destination_ip) {
            if (prev == NULL) {
                router->buckets[index] = current->next;
            } else {
                prev->next = current->next;
            }
            free(current);
            return;
        }
        prev = current;
        current = current->next;
    }
}

int routerGetNextHop(Router* router, int destination_ip) {
    if (router == NULL) return -1;

    int index = hash(destination_ip);
    RouteEntry* current = router->buckets[index];

    while (current != NULL) {
        if (current->destination_ip == destination_ip) {
            return current->next_hop_ip;
        }
        current = current->next;
    }
    return -1;
}

void routerFree(Router* router) {
    if (router == NULL) return;

    for (int i = 0; i < HASH_TABLE_SIZE; ++i) {
        RouteEntry* current = router->buckets[i];
        while (current != NULL) {
            RouteEntry* temp = current;
            current = current->next;
            free(temp);
        }
        router->buckets[i] = NULL;
    }
    free(router);
}