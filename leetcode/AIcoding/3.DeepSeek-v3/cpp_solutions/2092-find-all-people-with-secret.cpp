class Solution {
public:
    vector<int> findAllPeople(int n, vector<vector<int>>& meetings, int firstPerson) {
        vector<vector<pair<int, int>>> graph(n);
        for (auto& meeting : meetings) {
            int x = meeting[0], y = meeting[1], time = meeting[2];
            graph[x].emplace_back(y, time);
            graph[y].emplace_back(x, time);
        }

        vector<int> earliest(n, INT_MAX);
        earliest[0] = 0;
        earliest[firstPerson] = 0;

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.emplace(0, 0);
        pq.emplace(0, firstPerson);

        while (!pq.empty()) {
            auto [time, u] = pq.top();
            pq.pop();

            if (time > earliest[u]) continue;

            for (auto [v, t] : graph[u]) {
                if (t >= time && earliest[v] > t) {
                    earliest[v] = t;
                    pq.emplace(t, v);
                }
            }
        }

        vector<int> result;
        for (int i = 0; i < n; ++i) {
            if (earliest[i] != INT_MAX) {
                result.push_back(i);
            }
        }
        return result;
    }
};