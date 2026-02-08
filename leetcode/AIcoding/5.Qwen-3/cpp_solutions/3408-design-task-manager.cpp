#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>

using namespace std;

class Solution {
public:
    vector<int> assignTasks(vector<int>& servers, vector<int>& tasks) {
        int n = servers.size();
        int m = tasks.size();
        vector<int> result(m);

                priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> available;
        for (int i = 0; i < n; ++i) {
            available.push({servers[i], i});
        }

                priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<>> busy;

        int time = 0;
        for (int i = 0; i < m; ++i) {
                        if (available.empty()) {
                time = get<0>(busy.top());
            }

                        while (!busy.empty() && get<0>(busy.top()) <= time) {
                auto [end_time, weight, index] = busy.top();
                busy.pop();
                available.push({weight, index});
            }

                        auto [weight, index] = available.top();
            available.pop();
            result[i] = index;
            busy.push({time + tasks[i], weight, index});

                        time = max(time, i);
        }

        return result;
    }
};