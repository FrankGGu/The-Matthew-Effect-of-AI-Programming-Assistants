#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    vector<double> medianSlidingWindow(int nums[], int numsSize, int k) {
        vector<double> result;
        if (numsSize == 0 || k == 0) return result;

        priority_queue<int> maxHeap;         priority_queue<int, vector<int>, greater<int>> minHeap; 
        for (int i = 0; i < k; ++i) {
            if (maxHeap.empty() || nums[i] <= maxHeap.top()) {
                maxHeap.push(nums[i]);
            } else {
                minHeap.push(nums[i]);
            }
        }

                while (maxHeap.size() > minHeap.size() + 1) {
            minHeap.push(maxHeap.top());
            maxHeap.pop();
        }
        while (minHeap.size() > maxHeap.size()) {
            maxHeap.push(minHeap.top());
            minHeap.pop();
        }

                if (k % 2 == 0) {
            result.push_back((double)(maxHeap.top() + minHeap.top()) / 2);
        } else {
            result.push_back((double)maxHeap.top());
        }

        for (int i = k; i < numsSize; ++i) {
            int out = nums[i - k];
            int in = nums[i];

                        if (out <= maxHeap.top()) {
                maxHeap.remove(out);
            } else {
                minHeap.remove(out);
            }

                        if (in <= maxHeap.top()) {
                maxHeap.push(in);
            } else {
                minHeap.push(in);
            }

                        while (maxHeap.size() > minHeap.size() + 1) {
                minHeap.push(maxHeap.top());
                maxHeap.pop();
            }
            while (minHeap.size() > maxHeap.size()) {
                maxHeap.push(minHeap.top());
                minHeap.pop();
            }

                        if (k % 2 == 0) {
                result.push_back((double)(maxHeap.top() + minHeap.top()) / 2);
            } else {
                result.push_back((double)maxHeap.top());
            }
        }

        return result;
    }
};