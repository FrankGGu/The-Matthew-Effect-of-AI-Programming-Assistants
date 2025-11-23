#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> findHighestRatedServers(vector<int>& servers, int t) {
        int n = servers.size();
        vector<int> result;
        if (n == 0) return result;

        vector<pair<int, int>> serverList;
        for (int i = 0; i < n; ++i) {
            serverList.push_back({servers[i], i});
        }

        sort(serverList.begin(), serverList.end());

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        vector<int> count(n, 0);
        int currentTime = 0;

        for (int i = 0; i < t; ++i) {
            currentTime = i;

            while (!pq.empty() && pq.top().first <= currentTime) {
                auto [time, index] = pq.top();
                pq.pop();
                pq.push({time, index});
            }

            if (!pq.empty()) {
                auto [time, index] = pq.top();
                pq.pop();
                count[index]++;
                pq.push({currentTime + 1, index});
            } else {
                int idx = 0;
                for (int j = 0; j < n; ++j) {
                    if (serverList[j].second != -1) {
                        idx = serverList[j].second;
                        break;
                    }
                }
                count[idx]++;
                pq.push({currentTime + 1, idx});
                serverList[idx] = {0, -1};
            }
        }

        int maxCount = *max_element(count.begin(), count.end());
        for (int i = 0; i < n; ++i) {
            if (count[i] == maxCount) {
                result.push_back(i);
            }
        }

        return result;
    }
};