#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> maxSumOfThreeSubarrays(int* nums, int numsSize, int k) {
        vector<int> result;
        int n = numsSize;
        vector<int> prefix(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefix[i + 1] = prefix[i] + nums[i];
        }

        vector<int> left(n, 0);
        int maxSum = 0;
        int maxIndex = 0;
        for (int i = k - 1; i < n; ++i) {
            int current = prefix[i + 1] - prefix[i - k + 1];
            if (current > maxSum) {
                maxSum = current;
                maxIndex = i - k + 1;
            }
            left[i] = maxIndex;
        }

        vector<int> right(n, 0);
        maxSum = 0;
        maxIndex = n - 1;
        for (int i = n - k; i >= 0; --i) {
            int current = prefix[i + k] - prefix[i];
            if (current >= maxSum) {
                maxSum = current;
                maxIndex = i;
            }
            right[i] = maxIndex;
        }

        int maxTotal = 0;
        for (int i = k; i <= n - k; ++i) {
            int leftIndex = left[i - 1];
            int rightIndex = right[i + k];
            int current = (prefix[i + k] - prefix[i]) + (prefix[leftIndex + k] - prefix[leftIndex]) + (prefix[rightIndex + k] - prefix[rightIndex]);
            if (current > maxTotal) {
                maxTotal = current;
                result = {leftIndex, i, rightIndex};
            }
        }

        return result;
    }
};