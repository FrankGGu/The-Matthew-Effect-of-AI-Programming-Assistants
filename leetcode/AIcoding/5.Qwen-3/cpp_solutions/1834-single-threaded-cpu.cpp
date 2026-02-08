#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> getOrder(vector<vector<int>>& tasks) {
        int n = tasks.size();
        vector<pair<int, int>> taskList(n);
        for (int i = 0; i < n; ++i) {
            taskList[i] = {tasks[i][0], tasks[i][1], i};
        }

        sort(taskList.begin(), taskList.end(), [](const pair<int, int>& a, const pair<int, int>& b) {
            return a.first < b.first;
        });

        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<>> pq;
        vector<int> result;
        int time = 0;
        int i = 0;

        while (i < n || !pq.empty()) {
            if (pq.empty()) {
                time = max(time, taskList[i].first);
            }

            while (i < n && taskList[i].first <= time) {
                pq.push({taskList[i].second, taskList[i].second});
                ++i;
            }

            if (!pq.empty()) {
                auto [processTime, index] = pq.top();
                pq.pop();
                result.push_back(index);
                time += processTime;
            } else {
                time = taskList[i].first;
            }
        }

        return result;
    }
};