#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countFairPairs(int n, vector<int>& nums) {
        vector<int> sorted = nums;
        sort(sorted.begin(), sorted.end());
        int count = 0;
        int left = 0;
        int right = n - 1;
        while (left < right) {
            if (sorted[left] + sorted[right] < 0) {
                count += right - left;
                left++;
            } else {
                right--;
            }
        }
        return count;
    }
};