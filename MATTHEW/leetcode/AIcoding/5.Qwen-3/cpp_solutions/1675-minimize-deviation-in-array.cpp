#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minimumDeviation(vector<int>& nums) {
        int n = nums.size();
        priority_queue<int> maxHeap;
        int minVal = INT_MAX;

        for (int& num : nums) {
            if (num % 2 != 0) {
                num *= 2;
            }
            maxHeap.push(num);
            minVal = min(minVal, num);
        }

        int minDeviation = INT_MAX;

        while (true) {
            int currentMax = maxHeap.top();
            maxHeap.pop();
            minDeviation = min(minDeviation, currentMax - minVal);

            if (currentMax % 2 != 0) {
                break;
            }

            currentMax /= 2;
            minVal = min(minVal, currentMax);
            maxHeap.push(currentMax);
        }

        return minDeviation;
    }
};