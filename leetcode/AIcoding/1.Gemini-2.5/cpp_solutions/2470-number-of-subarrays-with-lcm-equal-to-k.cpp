#include <vector>
#include <numeric>

class Solution {
private:
    static long long calculate_lcm(long long a, long long b) {
        if (a == 0 || b == 0) return 0;
        if (a == 1) return b;
        if (b == 1) return a;
        return (a / std::gcd(a, b)) * b;
    }

public:
    int subarrayLCM(std::vector<int>& nums, int k) {
        int n = nums.size();
        int count = 0;

        for (int i = 0; i < n; ++i) {
            long long current_lcm = 1; 
            for (int j = i; j < n; ++j) {
                if (k % nums[j] != 0) {
                    break; 
                }

                current_lcm = calculate_lcm(current_lcm, nums[j]);

                if (current_lcm > k) {
                    break;
                }

                if (current_lcm == k) {
                    count++;
                }
            }
        }
        return count;
    }
};