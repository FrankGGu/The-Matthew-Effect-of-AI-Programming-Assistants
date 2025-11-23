class Solution {
public:
    int subarraysWithKDistinct(vector<int>& nums, int k) {
        return atMostK(nums, k) - atMostK(nums, k - 1);
    }

private:
    int atMostK(vector<int>& nums, int k) {
        unordered_map<int, int> count;
        int res = 0;
        int left = 0;
        for (int right = 0; right < nums.size(); ++right) {
            if (count[nums[right]] == 0) {
                k--;
            }
            count[nums[right]]++;
            while (k < 0) {
                count[nums[left]]--;
                if (count[nums[left]] == 0) {
                    k++;
                }
                left++;
            }
            res += right - left + 1;
        }
        return res;
    }
};