#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> assignTasks(vector<int>& servers, vector<int>& tasks) {
        int n = servers.size();
        int m = tasks.size();
        vector<int> result(m);

                        vector<pair<int, int>> sortedServers;
        for (int i = 0; i < n; ++i) {
            sortedServers.emplace_back(servers[i], i);
        }
        sort(sortedServers.begin(), sortedServers.end());

                priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> availableServers;
        for (const auto& s : sortedServers) {
            availableServers.push(s);
        }

                priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<>> busyServers;

        for (int time = 0; time < m; ++time) {
                        while (!busyServers.empty() && get<0>(busyServers.top()) <= time) {
                auto [availableTime, weight, id] = busyServers.top();
                busyServers.pop();
                availableServers.push({weight, id});
            }

                        if (availableServers.empty()) {
                auto [availableTime, weight, id] = busyServers.top();
                time = availableTime;
                while (!busyServers.empty() && get<0>(busyServers.top()) <= time) {
                    auto [t, w, i] = busyServers.top();
                    busyServers.pop();
                    availableServers.push({w, i});
                }
            }

                        auto [weight, id] = availableServers.top();
            availableServers.pop();
            result[time] = id;
            busyServers.push({time + tasks[time], weight, id});
        }

        return result;
    }
};