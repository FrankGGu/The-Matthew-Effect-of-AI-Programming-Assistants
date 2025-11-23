#include <iostream>
#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int numSubarraysWithGCD(vector<int>& nums, int k) {
        int count = 0;
        for (int i = 0; i < nums.size(); ++i) {
            int current_gcd = nums[i];
            if (current_gcd == k) ++count;
            for (int j = i + 1; j < nums.size(); ++j) {
                current_gcd = gcd(current_gcd, nums[j]);
                if (current_gcd == k) ++count;
                else if (current_gcd < k) break;
            }
        }
        return count;
    }
};