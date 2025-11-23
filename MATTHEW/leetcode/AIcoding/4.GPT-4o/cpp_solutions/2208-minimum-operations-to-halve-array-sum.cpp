#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    int halveArray(std::vector<int>& nums) {
        double total = 0;
        for (int num : nums) total += num;
        double half = total / 2;
        std::priority_queue<double> maxHeap(nums.begin(), nums.end());
        double sum = 0;
        int operations = 0;

        while (sum < half) {
            double largest = maxHeap.top();
            maxHeap.pop();
            sum += largest / 2;
            maxHeap.push(largest / 2);
            operations++;
        }

        return operations;
    }
};