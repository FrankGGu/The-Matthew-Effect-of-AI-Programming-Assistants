typedef struct {
    int key;
    int count;
    UT_hash_handle hh;
} Map;

typedef struct {
    int key;
    int val;
    struct Node* next;
} Node;

Map* map = NULL;
Node* graph = NULL;

void addEdge(int u, int v) {
    Node* newNode = (Node*)malloc(sizeof(Node));
    newNode->key = u;
    newNode->val = v;
    newNode->next = graph;
    graph = newNode;
}

void dfs(int u, int** result, int* idx) {
    Node* curr = graph;
    while (curr != NULL) {
        if (curr->key == u) {
            int v = curr->val;
            graph = curr->next;
            free(curr);
            dfs(v, result, idx);
            curr = graph;
        } else {
            curr = curr->next;
        }
    }
    (*idx)--;
    result[*idx][0] = u;
}

int** validArrangement(int** pairs, int pairsSize, int* pairsColSize, int* returnSize, int** returnColumnSizes) {
    map = NULL;
    graph = NULL;

    Map* degree = NULL;

    for (int i = 0; i < pairsSize; i++) {
        int u = pairs[i][0];
        int v = pairs[i][1];

        addEdge(u, v);

        Map* entry = NULL;
        HASH_FIND_INT(degree, &u, entry);
        if (!entry) {
            entry = (Map*)malloc(sizeof(Map));
            entry->key = u;
            entry->count = 0;
            HASH_ADD_INT(degree, key, entry);
        }
        entry->count++;

        entry = NULL;
        HASH_FIND_INT(degree, &v, entry);
        if (!entry) {
            entry = (Map*)malloc(sizeof(Map));
            entry->key = v;
            entry->count = 0;
            HASH_ADD_INT(degree, key, entry);
        }
        entry->count--;
    }

    int start = pairs[0][0];
    Map* curr;
    for (curr = degree; curr != NULL; curr = curr->hh.next) {
        if (curr->count == 1) {
            start = curr->key;
            break;
        }
    }

    int** result = (int**)malloc(pairsSize * sizeof(int*));
    for (int i = 0; i < pairsSize; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
    }

    int idx = pairsSize;
    dfs(start, result, &idx);

    for (int i = 0; i < pairsSize - 1; i++) {
        result[i][1] = result[i + 1][0];
    }
    result[pairsSize - 1][1] = result[0][1];

    *returnSize = pairsSize;
    *returnColumnSizes = (int*)malloc(pairsSize * sizeof(int));
    for (int i = 0; i < pairsSize; i++) {
        (*returnColumnSizes)[i] = 2;
    }

    Map *el, *tmp;
    HASH_ITER(hh, degree, el, tmp) {
        HASH_DEL(degree, el);
        free(el);
    }

    return result;
}