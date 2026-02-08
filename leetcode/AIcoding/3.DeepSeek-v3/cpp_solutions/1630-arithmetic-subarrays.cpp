class Solution {
public:
    vector<bool> checkArithmeticSubarrays(vector<int>& nums, vector<int>& l, vector<int>& r) {
        vector<bool> res;
        for (int i = 0; i < l.size(); ++i) {
            int left = l[i], right = r[i];
            vector<int> sub(nums.begin() + left, nums.begin() + right + 1);
            sort(sub.begin(), sub.end());
            int diff = sub[1] - sub[0];
            bool isArithmetic = true;
            for (int j = 2; j < sub.size(); ++j) {
                if (sub[j] - sub[j - 1] != diff) {
                    isArithmetic = false;
                    break;
                }
            }
            res.push_back(isArithmetic);
        }
        return res;
    }
};