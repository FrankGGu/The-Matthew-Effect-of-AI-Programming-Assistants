#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int maximumProduct(vector<int>& nums, int k) {
        priority_queue<int, vector<int>, greater<int>> minHeap;
        for (int num : nums) {
            minHeap.push(num);
        }

        while (k--) {
            int smallest = minHeap.top();
            minHeap.pop();
            minHeap.push(smallest + 1);
        }

        long long result = 1;
        while (!minHeap.empty()) {
            result = (result * minHeap.top()) % (1000000007);
            minHeap.pop();
        }

        return static_cast<int>(result);
    }
};