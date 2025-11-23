class Solution {
public:
    bool kLengthApart(std::vector<int>& nums, int k) {
        int last_one_idx = -k - 1; 

        for (int i = 0; i < nums.size(); ++i) {
            if (nums[i] == 1) {
                if (i - last_one_idx <= k) {
                    return false;
                }
                last_one_idx = i;
            }
        }

        return true;
    }
};