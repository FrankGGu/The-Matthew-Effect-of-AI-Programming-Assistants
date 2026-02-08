#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long countSubarrays(long long n, vector<int>& nums, long long k) {
        long long count = 0;
        long long sum = 0;
        long long left = 0;
        for (long long right = 0; right < n; ++right) {
            sum += nums[right];
            while (sum * (right - left + 1) >= k) {
                sum -= nums[left];
                ++left;
            }
            count += right - left + 1;
        }
        return count;
    }
};