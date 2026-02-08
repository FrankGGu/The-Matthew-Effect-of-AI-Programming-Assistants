#include <vector>
#include <queue>
#include <numeric>

class Solution {
public:
    long long minimumTravelTime(std::vector<int>& nums) {
        if (nums.empty()) {
            return 0;
        }
        if (nums.size() == 1) {
            return 0;
        }

        std::priority_queue<long long, std::vector<long long>, std::greater<long long>> pq;

        for (int num : nums) {
            pq.push(num);
        }

        long long totalCost = 0;

        while (pq.size() > 1) {
            long long first = pq.top();
            pq.pop();
            long long second = pq.top();
            pq.pop();

            long long currentMergeCost = first + second;
            totalCost += currentMergeCost;

            pq.push(currentMergeCost);
        }

        return totalCost;
    }
};