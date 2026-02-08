class Solution {
public:
    long long findTheArrayConcVal(vector<int>& nums) {
        long long res = 0;
        int left = 0, right = nums.size() - 1;
        while (left <= right) {
            if (left == right) {
                res += nums[left];
            } else {
                string concat = to_string(nums[left]) + to_string(nums[right]);
                res += stoll(concat);
            }
            left++;
            right--;
        }
        return res;
    }
};