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

                priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<>> busyServers;

        int time = 0;
        for (int i = 0; i < m; ++i) {
            time = max(time, i);
            if (availableServers.empty()) {
                                auto [t, w, idx] = busyServers.top();
                time = t;
                busyServers.pop();
                availableServers.push({w, idx});
            }

                        auto [weight, serverIdx] = availableServers.top();
            availableServers.pop();
            result[i] = serverIdx;
            busyServers.push({time + tasks[i], weight, serverIdx});
        }

        return result;
    }
};