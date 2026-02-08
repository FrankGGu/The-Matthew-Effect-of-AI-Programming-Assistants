#define MAXN 100001

int minFuelCost(int** roads, int roadsSize, int* roadsColSize, int seats) {
    int graph[MAXN][MAXN] = {0};
    int indegree[MAXN] = {0};
    long long fuelCost = 0;

    for (int i = 0; i < roadsSize; i++) {
        graph[roads[i][0]][roads[i][1]] = 1;
        graph[roads[i][1]][roads[i][0]] = 1;
        indegree[roads[i][0]]++;
        indegree[roads[i][1]]++;
    }

    int queue[MAXN], front = 0, rear = 0;
    queue[rear++] = 0;

    while (front < rear) {
        int node = queue[front++];
        int people = indegree[node] > 0 ? 1 : 0;
        for (int j = 0; j < MAXN; j++) {
            if (graph[node][j]) {
                people++;
                indegree[j]--;
                graph[node][j] = graph[j][node] = 0; // mark as visited
                if (indegree[j] > 0) {
                    queue[rear++] = j;
                }
            }
        }
        fuelCost += (people + seats - 1) / seats;
    }

    return fuelCost;
}