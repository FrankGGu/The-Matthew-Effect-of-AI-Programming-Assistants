#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int smallestDivisor(vector<int>& nums, int threshold) {
        auto isPossible = [&](int d) {
            int sum = 0;
            for (int num : nums) {
                sum += ceil(static_cast<double>(num) / d);
                if (sum > threshold) return false;
            }
            return true;
        };

        int left = 1, right = *max_element(nums.begin(), nums.end());
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (isPossible(mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
};