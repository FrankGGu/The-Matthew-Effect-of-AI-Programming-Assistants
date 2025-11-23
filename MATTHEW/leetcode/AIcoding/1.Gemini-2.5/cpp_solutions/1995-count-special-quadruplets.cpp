#include <vector>
#include <unordered_map>

class Solution {
public:
    int countQuadruplets(std::vector<int>& nums) {
        int n = nums.size();
        int count = 0;
        if (n < 4) {
            return 0;
        }

        std::unordered_map<int, int> freq;
        freq[nums[n - 1]] = 1;

        for (int c = n - 2; c >= 2; --c) {
            for (int a = 0; a < c - 1; ++a) {
                for (int b = a + 1; b < c; ++b) {
                    int sum = nums[a] + nums[b] + nums[c];
                    if (freq.count(sum)) {
                        count += freq[sum];
                    }
                }
            }
            freq[nums[c]]++;
        }

        return count;
    }
};