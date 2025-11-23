#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    long long sumOfSubarrays(vector<int>& nums) {
        int n = nums.size();
        long long total = 0;
        for (int i = 0; i < n; i++) {
            int count = 1;
            for (int j = i; j < n; j++) {
                total += nums[j] * count;
                count++;
            }
        }
        return total;
    }
};