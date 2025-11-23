typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} Map;

typedef struct {
    int* routes;
    int size;
    int capacity;
} RouteList;

typedef struct {
    int stop;
    int depth;
} QueueNode;

int numBusesToDestination(int** routes, int routesSize, int* routesColSize, int source, int target) {
    if (source == target) return 0;

    Map* stop_to_routes = NULL;
    for (int i = 0; i < routesSize; i++) {
        for (int j = 0; j < routesColSize[i]; j++) {
            int stop = routes[i][j];
            Map* entry;
            HASH_FIND_INT(stop_to_routes, &stop, entry);
            if (entry == NULL) {
                entry = (Map*)malloc(sizeof(Map));
                entry->key = stop;
                entry->val = i;
                HASH_ADD_INT(stop_to_routes, key, entry);
            }
        }
    }

    int* visited_route = (int*)calloc(routesSize, sizeof(int));
    int* visited_stop = (int*)calloc(100000, sizeof(int));

    QueueNode* queue = (QueueNode*)malloc(100000 * sizeof(QueueNode));
    int front = 0, rear = 0;

    visited_stop[source] = 1;
    queue[rear].stop = source;
    queue[rear].depth = 0;
    rear++;

    while (front < rear) {
        QueueNode current = queue[front++];
        int current_stop = current.stop;
        int current_depth = current.depth;

        Map* route_entry;
        HASH_FIND_INT(stop_to_routes, &current_stop, route_entry);
        while (route_entry != NULL) {
            int route_idx = route_entry->val;
            if (!visited_route[route_idx]) {
                visited_route[route_idx] = 1;
                for (int j = 0; j < routesColSize[route_idx]; j++) {
                    int next_stop = routes[route_idx][j];
                    if (!visited_stop[next_stop]) {
                        visited_stop[next_stop] = 1;
                        if (next_stop == target) {
                            free(visited_route);
                            free(visited_stop);
                            free(queue);
                            Map *current, *tmp;
                            HASH_ITER(hh, stop_to_routes, current, tmp) {
                                HASH_DEL(stop_to_routes, current);
                                free(current);
                            }
                            return current_depth + 1;
                        }
                        queue[rear].stop = next_stop;
                        queue[rear].depth = current_depth + 1;
                        rear++;
                    }
                }
            }
            route_entry = (Map*)route_entry->hh.next;
        }
    }

    free(visited_route);
    free(visited_stop);
    free(queue);
    Map *current, *tmp;
    HASH_ITER(hh, stop_to_routes, current, tmp) {
        HASH_DEL(stop_to_routes, current);
        free(current);
    }
    return -1;
}