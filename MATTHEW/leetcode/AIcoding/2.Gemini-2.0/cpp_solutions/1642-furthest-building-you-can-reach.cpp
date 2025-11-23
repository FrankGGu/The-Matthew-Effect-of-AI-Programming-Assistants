#include <queue>

class Solution {
public:
    int furthestBuilding(vector<int>& heights, int bricks, int ladders) {
        priority_queue<int> pq;
        int n = heights.size();
        for (int i = 0; i < n - 1; ++i) {
            int diff = heights[i + 1] - heights[i];
            if (diff > 0) {
                if (bricks >= diff) {
                    bricks -= diff;
                    pq.push(diff);
                } else if (ladders > 0) {
                    if (!pq.empty() && pq.top() > diff) {
                        bricks += pq.top();
                        pq.pop();
                        bricks -= diff;
                        pq.push(diff);
                    }
                    ladders--;
                } else {
                    return i;
                }
            }
        }
        return n - 1;
    }
};