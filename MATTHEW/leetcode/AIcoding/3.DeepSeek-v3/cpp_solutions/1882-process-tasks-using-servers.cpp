class Solution {
public:
    vector<int> assignTasks(vector<int>& servers, vector<int>& tasks) {
        int n = servers.size();
        int m = tasks.size();
        vector<int> res(m);

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> free;
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> busy;

        for (int i = 0; i < n; ++i) {
            free.push({servers[i], i});
        }

        int time = 0;
        for (int i = 0; i < m; ++i) {
            time = max(time, i);
            while (!busy.empty() && busy.top().first <= time) {
                auto [t, server] = busy.top();
                busy.pop();
                free.push(server);
            }
            if (free.empty()) {
                time = busy.top().first;
                while (!busy.empty() && busy.top().first <= time) {
                    auto [t, server] = busy.top();
                    busy.pop();
                    free.push(server);
                }
            }
            auto [weight, idx] = free.top();
            free.pop();
            res[i] = idx;
            busy.push({time + tasks[i], {weight, idx}});
        }

        return res;
    }
};