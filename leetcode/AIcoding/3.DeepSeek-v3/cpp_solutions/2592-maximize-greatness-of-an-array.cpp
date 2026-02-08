class Solution {
public:
    int maximizeGreatness(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int i = 0, j = 0;
        int n = nums.size();
        int res = 0;
        while (j < n) {
            if (nums[j] > nums[i]) {
                res++;
                i++;
            }
            j++;
        }
        return res;
    }
};