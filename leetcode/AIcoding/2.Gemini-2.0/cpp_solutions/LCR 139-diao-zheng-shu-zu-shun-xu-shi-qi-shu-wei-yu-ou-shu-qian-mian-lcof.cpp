#include <vector>

using namespace std;

class Solution {
public:
    vector<int> getOrder(vector<vector<int>>& tasks) {
        int n = tasks.size();
        vector<int> idx(n);
        for (int i = 0; i < n; ++i) {
            idx[i] = i;
        }
        sort(idx.begin(), idx.end(), [&](int i, int j) {
            return tasks[i][0] < tasks[j][0];
        });

        vector<int> ans;
        long long currentTime = 0;
        int taskIndex = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;

        while (ans.size() < n) {
            while (taskIndex < n && tasks[idx[taskIndex]][0] <= currentTime) {
                pq.push({tasks[idx[taskIndex]][1], idx[taskIndex]});
                taskIndex++;
            }

            if (pq.empty()) {
                if (taskIndex < n) {
                    currentTime = tasks[idx[taskIndex]][0];
                } else {
                    break;
                }
                continue;
            }

            auto [processTime, originalIndex] = pq.top();
            pq.pop();
            ans.push_back(originalIndex);
            currentTime += processTime;
        }

        return ans;
    }
};