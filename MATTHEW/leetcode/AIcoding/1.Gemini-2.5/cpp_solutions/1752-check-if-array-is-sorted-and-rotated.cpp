class Solution {
public:
    bool check(std::vector<int>& nums) {
        int n = nums.size();
        int descents = 0;

        for (int i = 0; i < n; ++i) {
            if (nums[i] > nums[(i + 1) % n]) {
                descent s++;
            }
        }

        return descents <= 1;
    }
};