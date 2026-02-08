#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minTimeToProcessTasks(vector<int>& tasks, int n) {
        priority_queue<int> pq;
        for (int task : tasks) {
            pq.push(task);
        }

        int time = 0;
        while (!pq.empty()) {
            vector<int> temp;
            int k = min(n, (int)pq.size());
            for (int i = 0; i < k; ++i) {
                temp.push_back(pq.top());
                pq.pop();
            }
            for (int task : temp) {
                if (--task > 0) {
                    pq.push(task);
                }
            }
            time++;
        }
        return time;
    }
};