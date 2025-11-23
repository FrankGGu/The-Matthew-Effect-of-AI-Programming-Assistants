#include <vector>
#include <queue>
#include <algorithm>
#include <set>

class Solution {
public:
    int minimumDeviation(std::vector<int>& nums) {
        std::priority_queue<int> pq;
        int min_val = INT_MAX;

        for (int num : nums) {
            if (num % 2 == 1) {
                num *= 2;
            }
            pq.push(num);
            min_val = std::min(min_val, num);
        }

        int min_dev = pq.top() - min_val;

        while (pq.top() % 2 == 0) {
            int max_val = pq.top();
            pq.pop();

            int new_val = max_val / 2;
            pq.push(new_val);
            min_val = std::min(min_val, new_val);

            min_dev = std::min(min_dev, pq.top() - min_val);
        }

        return min_dev;
    }
};