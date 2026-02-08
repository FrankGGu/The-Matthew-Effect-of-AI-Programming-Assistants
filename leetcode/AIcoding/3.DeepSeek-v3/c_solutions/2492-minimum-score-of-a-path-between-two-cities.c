typedef struct {
    int node;
    int weight;
    struct Node* next;
} Node;

typedef struct {
    Node** graph;
    int n;
    int* visited;
} Solution;

int min(int a, int b) {
    return a < b ? a : b;
}

void dfs(Solution* sol, int node, int* minEdge) {
    sol->visited[node] = 1;
    Node* curr = sol->graph[node];
    while (curr != NULL) {
        *minEdge = min(*minEdge, curr->weight);
        if (!sol->visited[curr->node]) {
            dfs(sol, curr->node, minEdge);
        }
        curr = curr->next;
    }
}

int minScore(int n, int** roads, int roadsSize, int* roadsColSize) {
    Solution sol;
    sol.n = n;
    sol.graph = (Node**)calloc(n + 1, sizeof(Node*));
    sol.visited = (int*)calloc(n + 1, sizeof(int));

    for (int i = 0; i < roadsSize; i++) {
        int u = roads[i][0];
        int v = roads[i][1];
        int w = roads[i][2];

        Node* newNode1 = (Node*)malloc(sizeof(Node));
        newNode1->node = v;
        newNode1->weight = w;
        newNode1->next = sol.graph[u];
        sol.graph[u] = newNode1;

        Node* newNode2 = (Node*)malloc(sizeof(Node));
        newNode2->node = u;
        newNode2->weight = w;
        newNode2->next = sol.graph[v];
        sol.graph[v] = newNode2;
    }

    int minEdge = INT_MAX;
    dfs(&sol, 1, &minEdge);

    for (int i = 1; i <= n; i++) {
        Node* curr = sol.graph[i];
        while (curr != NULL) {
            Node* temp = curr;
            curr = curr->next;
            free(temp);
        }
    }
    free(sol.graph);
    free(sol.visited);

    return minEdge;
}