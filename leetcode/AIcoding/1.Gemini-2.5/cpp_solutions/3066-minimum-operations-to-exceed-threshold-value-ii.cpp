#include <vector>
#include <queue>
#include <functional> // For std::greater

class Solution {
public:
    int minOperations(std::vector<int>& nums, int k) {
        std::priority_queue<long long, std::vector<long long>, std::greater<long long>> pq;

        for (int num : nums) {
            pq.push(num);
        }

        int operations = 0;
        while (pq.size() >= 2 && pq.top() < k) {
            long long x = pq.top();
            pq.pop();
            long long y = pq.top();
            pq.pop();

            pq.push(x + 2 * y);
            operations++;
        }

        return operations;
    }
};