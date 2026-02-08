#include <vector>
#include <queue>

class Solution {
public:
    int furthestBuilding(std::vector<int>& heights, int bricks, int ladders) {
        std::priority_queue<int> pq; 
        long long current_bricks = bricks; 

        for (int i = 0; i < heights.size() - 1; ++i) {
            int diff = heights[i+1] - heights[i];

            if (diff <= 0) {
                continue;
            }

            pq.push(diff);
            current_bricks -= diff;

            if (current_bricks < 0) {
                if (ladders > 0) {
                    current_bricks += pq.top();
                    pq.pop(); 
                    ladders--; 
                } else {
                    return i;
                }
            }
        }

        return heights.size() - 1;
    }
};