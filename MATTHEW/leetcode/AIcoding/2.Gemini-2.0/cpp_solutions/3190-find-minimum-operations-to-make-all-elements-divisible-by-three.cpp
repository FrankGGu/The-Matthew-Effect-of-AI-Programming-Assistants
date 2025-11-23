#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int n = nums.size();
        int ones = 1e9, twos = 1e9;
        for (int num : nums) {
            int rem = num % 3;
            if (rem == 0) continue;
            else if (rem == 1) {
                twos = min(twos, ones + 1);
                ones = min(ones, 1);
            } else {
                ones = min(ones, twos + 1);
                twos = min(twos, 1);
            }
        }

        if (accumulate(nums.begin(), nums.end(), 0LL) % 3 == 0) return 0;

        if (accumulate(nums.begin(), nums.end(), 0LL) % 3 == 1) {
            if (ones == 1e9) return -1;
            return ones;
        } else {
            if (twos == 1e9) return -1;
            return twos;
        }

    }
};