class Solution {
public:
    int semiOrderedPermutation(vector<int>& nums) {
        int n = nums.size();
        int first = find(nums.begin(), nums.end(), 1) - nums.begin();
        int last = find(nums.begin(), nums.end(), n) - nums.begin();

        int ans = 0;
        if (first < last) {
            ans = first + (n - 1 - last);
        } else {
            ans = first + (n - 1 - last) - 1;
        }

        return ans;
    }
};