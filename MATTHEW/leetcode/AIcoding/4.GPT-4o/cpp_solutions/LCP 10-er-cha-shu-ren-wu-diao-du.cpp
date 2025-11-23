#include <vector>
#include <algorithm>
#include <unordered_map>
#include <queue>
using namespace std;

class Solution {
public:
    int minimumTime(vector<vector<int>>& tasks) {
        int n = tasks.size();
        sort(tasks.begin(), tasks.end());
        priority_queue<int, vector<int>, greater<int>> pq;
        int time = 0;
        int idx = 0;

        while (idx < n || !pq.empty()) {
            if (pq.empty()) {
                time = max(time, tasks[idx][0]);
            }
            while (idx < n && tasks[idx][0] <= time) {
                pq.push(tasks[idx][1]);
                idx++;
            }
            time += pq.top();
            pq.pop();
        }

        return time;
    }
};