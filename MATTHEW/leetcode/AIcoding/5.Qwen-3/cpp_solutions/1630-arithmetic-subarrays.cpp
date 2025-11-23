#include <vector>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    vector<bool> checkArithmeticSubarrays(vector<int>& nums, vector<int>& l, vector<int>& r) {
        vector<bool> result;
        for (int i = 0; i < l.size(); ++i) {
            int left = l[i];
            int right = r[i];
            vector<int> sub(nums.begin() + left, nums.begin() + right + 1);
            sort(sub.begin(), sub.end());
            bool isArithmetic = true;
            int diff = sub[1] - sub[0];
            for (int j = 2; j < sub.size(); ++j) {
                if (sub[j] - sub[j - 1] != diff) {
                    isArithmetic = false;
                    break;
                }
            }
            result.push_back(isArithmetic);
        }
        return result;
    }
};