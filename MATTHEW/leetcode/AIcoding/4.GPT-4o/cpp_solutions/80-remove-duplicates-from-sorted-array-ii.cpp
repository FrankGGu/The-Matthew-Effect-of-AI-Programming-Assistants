class Solution {
public:
    int removeDuplicates(vector<int>& nums) {
        if (nums.size() <= 2) return nums.size();
        int count = 1, index = 1;

        for (int i = 1; i < nums.size(); ++i) {
            if (nums[i] == nums[i - 1]) {
                count++;
            } else {
                count = 1;
            }
            if (count <= 2) {
                nums[index++] = nums[i];
            }
        }
        return index;
    }
};