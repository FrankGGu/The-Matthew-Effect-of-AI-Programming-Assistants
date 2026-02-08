#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<int>& nums) {
        int operations = 0;
        int max_bits = 0;
        for (int num : nums) {
            int bits = 0;
            int temp = num;
            while (temp > 0) {
                bits++;
                temp >>= 1;
            }
            max_bits = max(max_bits, bits);
        }

        for (int i = 0; i < max_bits; ++i) {
            bool nonzero = false;
            for (int j = 0; j < nums.size(); ++j) {
                if (nums[j] % 2 != 0) {
                    nonzero = true;
                    nums[j]--;
                    operations++;
                }
            }
            if (nonzero) continue;

            bool all_zero = true;
            for(int num : nums){
                if(num != 0){
                    all_zero = false;
                    break;
                }
            }

            if(all_zero) break;

            for (int j = 0; j < nums.size(); ++j) {
                nums[j] /= 2;
            }
            if (!all_zero) operations++;
        }

        return operations;
    }
};