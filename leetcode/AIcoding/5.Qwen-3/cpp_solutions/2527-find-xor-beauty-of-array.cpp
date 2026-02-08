#include <vector>

using namespace std;

class Solution {
public:
    int xorBeauty(int n, vector<int>& nums) {
        int result = 0;
        for (int i = 0; i < n; ++i) {
            int count = 0;
            for (int j = 0; j < n; ++j) {
                if ((nums[i] & nums[j]) != 0) {
                    ++count;
                }
            }
            result ^= (nums[i] * count);
        }
        return result;
    }
};