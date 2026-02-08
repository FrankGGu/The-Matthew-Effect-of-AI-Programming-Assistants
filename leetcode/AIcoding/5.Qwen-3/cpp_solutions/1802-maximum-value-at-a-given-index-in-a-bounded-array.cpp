#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxValue(int n, int index, int maxSum) {
        long left = 1, right = maxSum;
        while (left < right) {
            long mid = (left + right + 1) / 2;
            long sum = 0;
            long leftVal = mid - 1;
            long rightVal = mid - 1;
            if (index < n - index) {
                sum += (leftVal * (leftVal + 1)) / 2;
                sum += (mid - 1) * (n - index - 1);
            } else {
                sum += (rightVal * (rightVal + 1)) / 2;
                sum += (mid - 1) * index;
            }
            if (sum < maxSum) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }
};