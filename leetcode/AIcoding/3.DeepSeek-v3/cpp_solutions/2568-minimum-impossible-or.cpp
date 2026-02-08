class Solution {
public:
    int minImpossibleOR(vector<int>& nums) {
        unordered_set<int> s(nums.begin(), nums.end());
        int res = 1;
        while (s.count(res)) {
            res <<= 1;
        }
        return res;
    }
};