class Solution {
public:
    int maxNonAdjacentSum(vector<int>& nums) {
        int include = 0, exclude = 0;
        for (int num : nums) {
            int new_exclude = max(include, exclude);
            include = exclude + num;
            exclude = new_exclude;
        }
        return max(include, exclude);
    }
};