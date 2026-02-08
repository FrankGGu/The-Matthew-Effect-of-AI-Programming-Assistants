class Solution {
public:
    int continuousSubarrays(vector<int>& nums) {
        int n = nums.size();
        int left = 0, right = 0, count = 0;
        multiset<int> window;

        while (right < n) {
            window.insert(nums[right]);
            while (*window.rbegin() - *window.begin() > 2) {
                window.erase(window.find(nums[left]));
                left++;
            }
            count += right - left + 1;
            right++;
        }
        return count;
    }
};