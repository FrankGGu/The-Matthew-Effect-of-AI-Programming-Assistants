class Solution {
public:
    int minimumArrayLength(vector<int>& nums) {
        int min_val = *min_element(nums.begin(), nums.end());
        int cnt = count(nums.begin(), nums.end(), min_val);
        for (int num : nums) {
            if (num % min_val != 0) {
                return 1;
            }
        }
        return (cnt + 1) / 2;
    }
};