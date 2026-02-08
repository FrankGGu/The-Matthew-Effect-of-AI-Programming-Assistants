class Solution {
public:
    bool canSortArray(vector<int>& nums) {
        vector<int> bits;
        for (int num : nums) {
            bits.push_back(__builtin_popcount(num));
        }

        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] < nums[i - 1]) {
                if (bits[i] != bits[i - 1]) {
                    return false;
                }
                int j = i;
                while (j > 0 && nums[j] < nums[j - 1] && bits[j] == bits[j - 1]) {
                    swap(nums[j], nums[j - 1]);
                    j--;
                }
            }
        }
        return true;
    }
};