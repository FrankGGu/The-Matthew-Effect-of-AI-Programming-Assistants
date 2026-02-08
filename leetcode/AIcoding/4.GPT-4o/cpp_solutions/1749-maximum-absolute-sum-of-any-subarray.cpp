class Solution {
public:
    int maxAbsoluteSum(vector<int>& nums) {
        int max_ending_here = 0, min_ending_here = 0;
        int max_so_far = 0, min_so_far = 0;

        for (int num : nums) {
            max_ending_here = max(max_ending_here + num, num);
            min_ending_here = min(min_ending_here + num, num);
            max_so_far = max(max_so_far, max_ending_here);
            min_so_far = min(min_so_far, min_ending_here);
        }

        return max(max_so_far, -min_so_far);
    }
};