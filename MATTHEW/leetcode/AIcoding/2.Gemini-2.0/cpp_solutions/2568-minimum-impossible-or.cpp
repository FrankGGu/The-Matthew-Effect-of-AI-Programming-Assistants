class Solution {
public:
    int minImpossibleOR(vector<int>& nums) {
        unordered_set<int> s(nums.begin(), nums.end());
        int ans = 1;
        while (s.count(ans)) {
            ans *= 2;
        }
        return ans;
    }
};