#include <vector>
#include <queue>
#include <set>

using namespace std;

class Solution {
public:
    vector<int> assignTasks(vector<int>& servers, vector<int>& tasks) {
        int n = servers.size();
        int m = tasks.size();
        vector<int> ans(m);

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> available;
        for (int i = 0; i < n; ++i) {
            available.push({servers[i], i});
        }

        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> busy;

        long long currentTime = 0;
        int taskIndex = 0;

        while (taskIndex < m) {
            if (available.empty() && (busy.empty() || busy.top().first > currentTime)) {
                currentTime = busy.top().first;
            }

            while (!busy.empty() && busy.top().first <= currentTime) {
                available.push({servers[busy.top().second], busy.top().second});
                busy.pop();
            }

            while (!available.empty() && taskIndex <= currentTime && taskIndex < m) {
                auto server = available.top();
                available.pop();
                ans[taskIndex] = server.second;
                busy.push({currentTime + tasks[taskIndex], server.second});
                taskIndex++;
            }
            if(taskIndex <= currentTime) continue;
            currentTime++;
        }

        return ans;
    }
};