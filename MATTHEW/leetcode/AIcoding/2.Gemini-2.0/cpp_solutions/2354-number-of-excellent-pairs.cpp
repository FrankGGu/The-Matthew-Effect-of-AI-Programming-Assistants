#include <vector>

using namespace std;

class Solution {
public:
    long long countExcellentPairs(vector<int>& nums, int k) {
        vector<int> bits(32, 0);
        vector<bool> seen(100001, false);
        int uniqueCount = 0;

        for (int num : nums) {
            if (!seen[num]) {
                seen[num] = true;
                int count = 0;
                int temp = num;
                while (temp > 0) {
                    count += (temp & 1);
                    temp >>= 1;
                }
                bits[count]++;
                uniqueCount++;
            }
        }

        long long result = 0;
        for (int i = 0; i < 32; ++i) {
            if (bits[i] > 0) {
                for (int j = 0; j < 32; ++j) {
                    if (bits[j] > 0) {
                        if (i + j >= k) {
                            result += (long long)bits[i] * bits[j];
                        }
                    }
                }
            }
        }

        return result;
    }
};