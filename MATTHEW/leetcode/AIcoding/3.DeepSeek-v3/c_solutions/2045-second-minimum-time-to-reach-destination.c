typedef struct {
    int node;
    int time;
} State;

int secondMinimum(int n, int** edges, int edgesSize, int* edgesColSize, int time, int change) {
    vector<vector<int>> graph(n + 1);
    for (int i = 0; i < edgesSize; i++) {
        int u = edges[i][0], v = edges[i][1];
        graph[u].push_back(v);
        graph[v].push_back(u);
    }

    vector<int> dist1(n + 1, INT_MAX), dist2(n + 1, INT_MAX);
    dist1[1] = 0;

    queue<State> q;
    q.push((State){1, 0});

    while (!q.empty()) {
        State curr = q.front();
        q.pop();

        for (int neighbor : graph[curr.node]) {
            int nextTime = curr.time + time;
            if ((curr.time / change) % 2 == 1) {
                nextTime = ((curr.time / change) + 1) * change + time;
            }

            if (dist1[neighbor] > nextTime) {
                dist2[neighbor] = dist1[neighbor];
                dist1[neighbor] = nextTime;
                q.push((State){neighbor, nextTime});
            } else if (nextTime > dist1[neighbor] && nextTime < dist2[neighbor]) {
                dist2[neighbor] = nextTime;
                q.push((State){neighbor, nextTime});
            }
        }
    }

    return dist2[n];
}