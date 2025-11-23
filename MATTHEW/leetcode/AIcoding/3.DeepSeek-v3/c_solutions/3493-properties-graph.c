typedef struct {
    int key;
    int val;
    UT_hash_handle hh;
} HashItem;

typedef struct {
    int node;
    int weight;
} Edge;

int dfs(int node, HashItem** graph, int* visited) {
    visited[node] = 1;
    int max_len = 0;

    HashItem* curr;
    Edge* edges;
    HASH_FIND_INT(graph[node], &node, curr);
    if (curr) {
        edges = (Edge*)curr->val;
        int edge_count = curr->key;
        for (int i = 0; i < edge_count; i++) {
            int neighbor = edges[i].node;
            int weight = edges[i].weight;
            if (!visited[neighbor]) {
                int len = weight + dfs(neighbor, graph, visited);
                if (len > max_len) max_len = len;
            }
        }
    }

    visited[node] = 0;
    return max_len;
}

int numberOfProperties(int n, int** properties, int propertiesSize, int* propertiesColSize) {
    HashItem** graph = (HashItem**)calloc(n, sizeof(HashItem*));
    int* in_degree = (int*)calloc(n, sizeof(int));

    for (int i = 0; i < propertiesSize; i++) {
        int u = properties[i][0];
        int v = properties[i][1];
        int w = properties[i][2];

        HashItem* item;
        HASH_FIND_INT(graph[u], &u, item);
        if (!item) {
            item = (HashItem*)malloc(sizeof(HashItem));
            item->key = u;
            item->val = (int)malloc(sizeof(Edge) * 10);
            ((Edge*)item->val)[0].node = v;
            ((Edge*)item->val)[0].weight = w;
            item->key = 1;
            HASH_ADD_INT(graph[u], key, item);
        } else {
            int count = item->key;
            if (count % 10 == 0) {
                item->val = (int)realloc(item->val, sizeof(Edge) * (count + 10));
            }
            ((Edge*)item->val)[count].node = v;
            ((Edge*)item->val)[count].weight = w;
            item->key = count + 1;
        }
        in_degree[v]++;
    }

    int* visited = (int*)calloc(n, sizeof(int));
    int max_properties = 0;

    for (int i = 0; i < n; i++) {
        if (in_degree[i] == 0) {
            int len = dfs(i, graph, visited);
            if (len > max_properties) max_properties = len;
        }
    }

    for (int i = 0; i < n; i++) {
        HashItem *curr, *tmp;
        HASH_ITER(hh, graph[i], curr, tmp) {
            HASH_DEL(graph[i], curr);
            free(curr->val);
            free(curr);
        }
    }
    free(graph);
    free(in_degree);
    free(visited);

    return max_properties;
}