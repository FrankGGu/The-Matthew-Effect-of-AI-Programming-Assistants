#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMaximumXOR(vector<int>& nums) {
        int maxXor = 0;
        for (int i = 0; i < nums.size(); ++i) {
            for (int j = i + 1; j < nums.size(); ++j) {
                maxXor = max(maxXor, nums[i] ^ nums[j]);
            }
        }
        return maxXor;
    }
};