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

                priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> availableServers;
        for (int i = 0; i < n; ++i) {
            availableServers.push({servers[i], i});
        }

                unordered_map<int, long long> serverAvailableTime;

                long long time = 0;

                queue<pair<int, int>> processingTasks;

        for (int i = 0; i < m; ++i) {
                        if (time > i) {
                time = i;
            }

                        while (availableServers.empty() && !processingTasks.empty()) {
                time = max(time, processingTasks.front().first);
                auto [serverTime, serverIndex] = processingTasks.front();
                processingTasks.pop();
                serverAvailableTime[serverIndex] = serverTime;
                availableServers.push({servers[serverIndex], serverIndex});
            }

                        if (!availableServers.empty()) {
                auto [weight, index] = availableServers.top();
                availableServers.pop();
                result[i] = index;
                processingTasks.push({time + tasks[i], index});
            } else {
                                time = processingTasks.front().first;
                auto [serverTime, serverIndex] = processingTasks.front();
                processingTasks.pop();
                serverAvailableTime[serverIndex] = serverTime;
                availableServers.push({servers[serverIndex], serverIndex});
                --i;
            }
        }

        return result;
    }
};