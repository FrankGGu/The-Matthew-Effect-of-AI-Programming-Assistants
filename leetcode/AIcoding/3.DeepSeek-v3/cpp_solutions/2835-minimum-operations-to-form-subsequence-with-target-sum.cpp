class Solution {
public:
    int minOperations(vector<int>& nums, int target) {
        long long sum = accumulate(nums.begin(), nums.end(), 0LL);
        if (sum < target) return -1;

        sort(nums.begin(), nums.end());
        int res = 0;
        while (target > 0) {
            int num = nums.back();
            nums.pop_back();
            if (sum - num >= target) {
                sum -= num;
            } else if (num <= target) {
                sum -= num;
                target -= num;
            } else {
                res++;
                nums.push_back(num / 2);
                nums.push_back(num / 2);
            }
        }
        return res;
    }
};