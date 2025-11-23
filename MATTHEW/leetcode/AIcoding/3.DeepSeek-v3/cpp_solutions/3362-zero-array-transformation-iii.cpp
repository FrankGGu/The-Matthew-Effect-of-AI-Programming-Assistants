#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperations(vector<int>& nums) {
        int res = 0;
        while (true) {
            int min_non_zero = INT_MAX;
            for (int num : nums) {
                if (num > 0 && num < min_non_zero) {
                    min_non_zero = num;
                }
            }
            if (min_non_zero == INT_MAX) {
                break;
            }
            for (int &num : nums) {
                if (num > 0) {
                    num -= min_non_zero;
                }
            }
            res++;
        }
        return res;
    }
};