#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int numberOfNonSpecialSubsequences(const vector<int>& nums) {
        int mod = 1e9 + 7;
        int count0 = 0, count1 = 0, count2 = 0;

        for (int num : nums) {
            if (num == 0) {
                count0 = (count0 * 2 + 1) % mod;
            } else if (num == 1) {
                count1 = (count1 * 2 + count0) % mod;
            } else if (num == 2) {
                count2 = (count2 * 2 + count1) % mod;
            }
        }

        return count2;
    }
};