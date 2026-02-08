class Solution {
public:
    std::vector<int> getConcatenation(std::vector<int>& nums) {
        std::vector<int> ans = nums;
        ans.insert(ans.end(), nums.begin(), nums.end());
        return ans;
    }
};