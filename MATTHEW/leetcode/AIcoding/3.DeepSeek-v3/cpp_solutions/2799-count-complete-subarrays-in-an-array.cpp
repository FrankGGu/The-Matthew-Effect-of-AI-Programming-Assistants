class Solution {
public:
    int countCompleteSubarrays(vector<int>& nums) {
        unordered_set<int> distinct(nums.begin(), nums.end());
        int total_distinct = distinct.size();
        int n = nums.size();
        int res = 0;

        for (int i = 0; i < n; ++i) {
            unordered_set<int> current;
            for (int j = i; j < n; ++j) {
                current.insert(nums[j]);
                if (current.size() == total_distinct) {
                    res += (n - j);
                    break;
                }
            }
        }

        return res;
    }
};