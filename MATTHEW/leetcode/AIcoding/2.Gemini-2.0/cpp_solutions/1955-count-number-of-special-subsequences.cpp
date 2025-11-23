#include <vector>

using namespace std;

class Solution {
public:
    int countSpecialSubsequences(vector<int>& nums) {
        long long mod = 1e9 + 7;
        long long endWith0 = 0, endWith1 = 0, endWith2 = 0;

        for (int num : nums) {
            if (num == 0) {
                endWith0 = (2 * endWith0 + 1) % mod;
            } else if (num == 1) {
                endWith1 = (2 * endWith1 + endWith0) % mod;
            } else {
                endWith2 = (2 * endWith2 + endWith1) % mod;
            }
        }

        return endWith2;
    }
};