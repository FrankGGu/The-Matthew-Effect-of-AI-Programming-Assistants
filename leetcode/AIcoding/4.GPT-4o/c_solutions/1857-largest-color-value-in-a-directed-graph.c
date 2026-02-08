#define MAXN 100
#define MAXC 26

typedef struct {
    int in_degree[MAXN];
    int adj[MAXN][MAXN];
    int color_count[MAXN][MAXC];
    int visited[MAXN];
    int stack[MAXN];
    int stack_size;
    int n;
} Graph;

void init_graph(Graph* g, int n) {
    g->n = n;
    for (int i = 0; i < n; i++) {
        g->in_degree[i] = 0;
        g->visited[i] = 0;
        for (int j = 0; j < n; j++) {
            g->adj[i][j] = 0;
        }
        for (int j = 0; j < MAXC; j++) {
            g->color_count[i][j] = 0;
        }
    }
    g->stack_size = 0;
}

void add_edge(Graph* g, int u, int v) {
    g->adj[u][v] = 1;
    g->in_degree[v]++;
}

int topological_sort(Graph* g, int* colors, int* result) {
    int queue[MAXN], front = 0, rear = 0, count = 0;
    for (int i = 0; i < g->n; i++) {
        if (g->in_degree[i] == 0) {
            queue[rear++] = i;
        }
    }

    while (front < rear) {
        int u = queue[front++];
        result[count++] = u;
        for (int v = 0; v < g->n; v++) {
            if (g->adj[u][v]) {
                g->in_degree[v]--;
                if (g->in_degree[v] == 0) {
                    queue[rear++] = v;
                }
            }
        }
    }
    return count == g->n;
}

int largestColorValue(char* colors, int** edges, int edgesSize, int* edgesColSize) {
    Graph g;
    init_graph(&g, strlen(colors));

    for (int i = 0; i < edgesSize; i++) {
        add_edge(&g, edges[i][0], edges[i][1]);
    }

    int result[MAXN];
    if (!topological_sort(&g, (int*)colors, result)) {
        return -1;
    }

    int max_color_value = 0;
    for (int i = 0; i < g.n; i++) {
        int node = result[i];
        g.color_count[node][colors[node] - 'a']++;
        for (int v = 0; v < g.n; v++) {
            if (g.adj[node][v]) {
                for (int c = 0; c < MAXC; c++) {
                    g.color_count[v][c] = fmax(g.color_count[v][c], g.color_count[node][c]);
                }
            }
        }
    }

    for (int i = 0; i < g.n; i++) {
        max_color_value = fmax(max_color_value, g.color_count[i][colors[i] - 'a']);
    }

    return max_color_value;
}