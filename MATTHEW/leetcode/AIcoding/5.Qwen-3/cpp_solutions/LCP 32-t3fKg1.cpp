#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> assignTasks(vector<int>& servers, vector<int>& tasks) {
        int n = servers.size();
        int m = tasks.size();
        vector<int> result(m);

                priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> availableServers;
        for (int i = 0; i < n; ++i) {
            availableServers.push({servers[i], i});
        }

                priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> busyServers;

        int time = 0;
        for (int i = 0; i < m; ++i) {
            time = max(time, i);
            if (availableServers.empty()) {
                time = busyServers.top().first;
            }

                        while (!busyServers.empty() && busyServers.top().first <= time) {
                auto [serverTime, serverIndex] = busyServers.top();
                busyServers.pop();
                availableServers.push({servers[serverIndex], serverIndex});
            }

                        auto [serverWeight, serverIndex] = availableServers.top();
            availableServers.pop();
            result[i] = serverIndex;
            busyServers.push({time + tasks[i], serverIndex});
        }

        return result;
    }
};