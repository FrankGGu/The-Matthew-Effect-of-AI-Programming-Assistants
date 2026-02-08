class Solution {
public:
    int minimumCost(int startX, int startY, int targetX, int targetY, vector<vector<int>>& specialRoads) {
        int n = specialRoads.size();
        vector<vector<int>> dist(101, vector<int>(101, INT_MAX));
        dist[startX][startY] = 0;

        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<tuple<int, int, int>>> pq;
        pq.push({0, startX, startY});

        while (!pq.empty()) {
            auto [cost, x, y] = pq.top();
            pq.pop();

            if (cost > dist[x][y]) continue;

            if (x == targetX && y == targetY) return cost;

            for (const auto& road : specialRoads) {
                int sx = road[0], sy = road[1], ex = road[2], ey = road[3], c = road[4];
                int newCost = cost + c + abs(sx - x) + abs(sy - y);
                if (newCost < dist[ex][ey]) {
                    dist[ex][ey] = newCost;
                    pq.push({newCost, ex, ey});
                }
            }
        }

        return dist[targetX][targetY] == INT_MAX ? -1 : dist[targetX][targetY];
    }
};