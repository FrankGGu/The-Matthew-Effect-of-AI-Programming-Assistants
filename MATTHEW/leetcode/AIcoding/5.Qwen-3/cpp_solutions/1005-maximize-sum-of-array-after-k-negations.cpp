#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int largestSumAfterKNegations(vector<int>& nums, int k) {
        priority_queue<int, vector<int>, greater<int>> minHeap;
        for (int num : nums) {
            minHeap.push(num);
        }

        while (k > 0 && !minHeap.empty()) {
            int smallest = minHeap.top();
            if (smallest < 0) {
                minHeap.pop();
                minHeap.push(-smallest);
                k--;
            } else {
                break;
            }
        }

        while (k > 0) {
            int smallest = minHeap.top();
            minHeap.pop();
            minHeap.push(-smallest);
            k--;
        }

        int sum = 0;
        while (!minHeap.empty()) {
            sum += minHeap.top();
            minHeap.pop();
        }

        return sum;
    }
};