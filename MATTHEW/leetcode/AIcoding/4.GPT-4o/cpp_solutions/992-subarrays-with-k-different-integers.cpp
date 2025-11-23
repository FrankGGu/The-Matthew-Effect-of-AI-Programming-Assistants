class Solution {
public:
    int subarraysWithKDistinct(vector<int>& nums, int k) {
        return atMostK(nums, k) - atMostK(nums, k - 1);
    }

    int atMostK(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        int left = 0, right = 0, res = 0;

        while (right < nums.size()) {
            if (count[nums[right]] == 0) k--;
            count[nums[right]]++;
            right++;

            while (k < 0) {
                count[nums[left]]--;
                if (count[nums[left]] == 0) k++;
                left++;
            }
            res += right - left;
        }

        return res;
    }
};