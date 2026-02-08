#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> assignTasks(vector<int>& servers, vector<int>& tasks) {
        int n = servers.size(), m = tasks.size();
        vector<int> ans(m);
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> available_servers;
        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> busy_servers;

        for (int i = 0; i < n; ++i) {
            available_servers.push({servers[i], i});
        }

        long long current_time = 0;

        for (int i = 0; i < m; ++i) {
            current_time = max(current_time, (long long)i);
            while (!busy_servers.empty() && busy_servers.top().first <= current_time) {
                available_servers.push({servers[busy_servers.top().second], busy_servers.top().second});
                busy_servers.pop();
            }

            if (available_servers.empty()) {
                current_time = busy_servers.top().first;
                while (!busy_servers.empty() && busy_servers.top().first <= current_time) {
                    available_servers.push({servers[busy_servers.top().second], busy_servers.top().second});
                    busy_servers.pop();
                }
            }

            auto [server_time, server_id] = available_servers.top();
            available_servers.pop();
            ans[i] = server_id;
            busy_servers.push({current_time + tasks[i] + server_time, server_id});
        }

        return ans;
    }
};