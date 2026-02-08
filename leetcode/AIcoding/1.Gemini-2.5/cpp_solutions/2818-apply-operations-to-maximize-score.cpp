#include <vector>
#include <queue>

class Solution {
public:
    long long maxScore(std::vector<int>& nums, int k) {
        std::priority_queue<int> pq;

        for (int num : nums) {
            pq.push(num);
        }

        long long totalScore = 0;

        for (int i = 0; i < k; ++i) {
            int currentMax = pq.top();
            pq.pop();
            totalScore += currentMax;
            pq.push(currentMax / 3);
        }

        return totalScore;
    }
};