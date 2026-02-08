typedef struct {
    char* key;
    double value;
    UT_hash_handle hh;
} HashNode;

double dfs(char* start, char* end, HashNode* graph, HashNode* visited) {
    if (strcmp(start, end) == 0) return 1.0;

    HashNode* node;
    HASH_FIND_STR(graph, start, node);
    if (!node) return -1.0;

    HashNode* tmp;
    HASH_FIND_STR(visited, start, tmp);
    if (tmp) return -1.0;

    HashNode* newVisited = malloc(sizeof(HashNode));
    newVisited->key = start;
    HASH_ADD_STR(visited, key, newVisited);

    HashNode* curr = node;
    while (curr) {
        if (curr->key == start) {
            char* next = (char*)(curr + 1);
            double val = curr->value;
            double res = dfs(next, end, graph, visited);
            if (res != -1.0) {
                HASH_DEL(visited, newVisited);
                free(newVisited);
                return val * res;
            }
        }
        curr = curr->hh.next;
    }

    HASH_DEL(visited, newVisited);
    free(newVisited);
    return -1.0;
}

double* calcEquation(char*** equations, int equationsSize, int* equationsColSize, double* values, int valuesSize, char*** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    HashNode* graph = NULL;

    for (int i = 0; i < equationsSize; i++) {
        char* a = equations[i][0];
        char* b = equations[i][1];
        double val = values[i];

        HashNode* node1 = malloc(sizeof(HashNode) + strlen(b) + 1);
        node1->key = a;
        node1->value = val;
        strcpy((char*)(node1 + 1), b);
        HASH_ADD_STR(graph, key, node1);

        HashNode* node2 = malloc(sizeof(HashNode) + strlen(a) + 1);
        node2->key = b;
        node2->value = 1.0 / val;
        strcpy((char*)(node2 + 1), a);
        HASH_ADD_STR(graph, key, node2);
    }

    double* result = malloc(queriesSize * sizeof(double));
    *returnSize = queriesSize;

    for (int i = 0; i < queriesSize; i++) {
        char* start = queries[i][0];
        char* end = queries[i][1];

        HashNode* visited = NULL;
        double res = dfs(start, end, graph, visited);

        HashNode *curr, *tmp;
        HASH_ITER(hh, visited, curr, tmp) {
            HASH_DEL(visited, curr);
            free(curr);
        }

        result[i] = res;
    }

    HashNode *curr, *tmp;
    HASH_ITER(hh, graph, curr, tmp) {
        HASH_DEL(graph, curr);
        free(curr);
    }

    return result;
}