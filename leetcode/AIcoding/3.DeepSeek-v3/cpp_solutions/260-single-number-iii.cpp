class Solution {
public:
    vector<int> singleNumber(vector<int>& nums) {
        long long diff = 0;
        for (int num : nums) {
            diff ^= num;
        }
        diff &= -diff;

        vector<int> res(2, 0);
        for (int num : nums) {
            if ((num & diff) == 0) {
                res[0] ^= num;
            } else {
                res[1] ^= num;
            }
        }
        return res;
    }
};