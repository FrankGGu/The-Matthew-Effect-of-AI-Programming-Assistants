class Solution {
public:
    int countSubarrays(vector<int>& nums) {
        int n = nums.size();
        int left = 0, right = 0;

        while (left < n && nums[left] == left + 1) {
            left++;
        }

        right = n - 1;
        while (right >= 0 && nums[right] == right + 1) {
            right--;
        }

        if (left > right) return n;

        int count = 0;
        for (int i = left; i <= right; i++) {
            if (nums[i] != i + 1) {
                count++;
            }
        }

        return count + (right - left + 1);
    }
};