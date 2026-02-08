#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumDeletions(vector<int>& nums) {
        int n = nums.size();
        if (n <= 2) return n;

        int minIndex = 0;
        int maxIndex = 0;

        for (int i = 1; i < n; ++i) {
            if (nums[i] < nums[minIndex]) {
                minIndex = i;
            }
            if (nums[i] > nums[maxIndex]) {
                maxIndex = i;
            }
        }

        int left = min(minIndex, maxIndex) + 1;
        int right = n - max(maxIndex, minIndex);
        int both = left + right;

        return min(both, max(left, right));
    }
};