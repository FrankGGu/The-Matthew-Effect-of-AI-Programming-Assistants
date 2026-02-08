#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minTimeToBreakLocks(vector<int>& locks, int time) {
        priority_queue<int, vector<int>, greater<int>> pq;
        int totalTime = 0;

        for (int lock : locks) {
            pq.push(lock);
        }

        while (!pq.empty()) {
            int current = pq.top();
            pq.pop();
            totalTime += current;
            if (!pq.empty()) {
                totalTime += time;
            }
        }

        return totalTime;
    }
};