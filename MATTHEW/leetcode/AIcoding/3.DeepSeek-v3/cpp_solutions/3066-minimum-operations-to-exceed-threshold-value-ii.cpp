#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums, int k) {
        priority_queue<long long, vector<long long>, greater<long long>> minHeap;
        for (int num : nums) {
            minHeap.push(num);
        }

        int operations = 0;
        while (minHeap.size() >= 2 && minHeap.top() < k) {
            long long smallest = minHeap.top();
            minHeap.pop();
            long long secondSmallest = minHeap.top();
            minHeap.pop();

            long long combined = smallest * 2 + secondSmallest;
            minHeap.push(combined);
            operations++;
        }

        return operations;
    }
};