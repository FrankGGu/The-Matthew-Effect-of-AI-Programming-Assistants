#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums1, vector<int>& nums2, int k) {
        int sum1 = 0, sum2 = 0;
        for (int num : nums1) sum1 += num;
        for (int num : nums2) sum2 += num;

        if (sum1 == sum2) return 0;

        if (sum1 > sum2) {
            swap(nums1, nums2);
            swap(sum1, sum2);
        }

        int diff = sum2 - sum1;
        int operations = 0;

        priority_queue<int> maxHeap;
        for (int num : nums1) maxHeap.push(num);
        for (int num : nums2) maxHeap.push(num);

        while (!maxHeap.empty() && diff > 0) {
            int top = maxHeap.top();
            maxHeap.pop();

            if (top < 1) break;

            int gain = top - 1;
            diff -= gain;
            operations++;
        }

        if (diff > 0) return -1;
        return operations;
    }
};