class Solution {
public:
    int minimumRightShifts(vector<int>& nums) {
        int n = nums.size();
        vector<int> sorted_nums = nums;
        sort(sorted_nums.begin(), sorted_nums.end());

        if (nums == sorted_nums) return 0;

        int shifts = 0;
        while (shifts < n) {
            if (rotate(nums.begin(), nums.begin() + 1, nums.end()), nums == sorted_nums) 
                return shifts + 1;
            shifts++;
        }

        return -1;
    }
};