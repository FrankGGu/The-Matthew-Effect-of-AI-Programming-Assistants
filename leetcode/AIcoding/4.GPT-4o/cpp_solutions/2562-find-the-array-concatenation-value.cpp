class Solution {
public:
    long long findTheArrayConcVal(vector<int>& nums) {
        long long result = 0;
        int n = nums.size();
        for (int i = 0; i < (n + 1) / 2; ++i) {
            if (i != n - i - 1) {
                result += stoll(to_string(nums[i]) + to_string(nums[n - i - 1]));
            } else {
                result += nums[i];
            }
        }
        return result;
    }
};