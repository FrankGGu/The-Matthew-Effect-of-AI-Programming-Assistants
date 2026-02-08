class Solution {
public:
    int thirdMax(vector<int>& nums) {
        set<int> unique_nums(nums.begin(), nums.end());
        if (unique_nums.size() < 3) {
            return *unique_nums.rbegin();
        }
        auto it = unique_nums.end();
        advance(it, -3);
        return *it;
    }
};