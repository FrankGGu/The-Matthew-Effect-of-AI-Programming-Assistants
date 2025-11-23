class Solution {
public:
    int networkDelayTime(vector<vector<int>>& times, int N, int K) {
        vector<vector<pair<int, int>>> graph(N + 1);
        for (const auto& time : times) {
            graph[time[0]].emplace_back(time[1], time[2]);
        }

        vector<int> dist(N + 1, INT_MAX);
        dist[K] = 0;

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.emplace(0, K);

        while (!pq.empty()) {
            auto [time, node] = pq.top();
            pq.pop();
            if (time > dist[node]) continue;
            for (const auto& [neighbor, weight] : graph[node]) {
                if (dist[node] + weight < dist[neighbor]) {
                    dist[neighbor] = dist[node] + weight;
                    pq.emplace(dist[neighbor], neighbor);
                }
            }
        }

        int maxTime = *max_element(dist.begin() + 1, dist.end());
        return maxTime == INT_MAX ? -1 : maxTime;
    }
};