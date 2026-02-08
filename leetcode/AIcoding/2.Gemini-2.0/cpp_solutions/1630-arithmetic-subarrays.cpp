#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<bool> checkArithmeticSubarrays(vector<int>& nums, vector<int>& l, vector<int>& r) {
        int m = l.size();
        vector<bool> result(m);
        for (int i = 0; i < m; ++i) {
            int left = l[i];
            int right = r[i];
            vector<int> subarray(nums.begin() + left, nums.begin() + right + 1);
            sort(subarray.begin(), subarray.end());
            if (subarray.size() <= 2) {
                result[i] = true;
            } else {
                int diff = subarray[1] - subarray[0];
                bool isArithmetic = true;
                for (int j = 2; j < subarray.size(); ++j) {
                    if (subarray[j] - subarray[j - 1] != diff) {
                        isArithmetic = false;
                        break;
                    }
                }
                result[i] = isArithmetic;
            }
        }
        return result;
    }
};