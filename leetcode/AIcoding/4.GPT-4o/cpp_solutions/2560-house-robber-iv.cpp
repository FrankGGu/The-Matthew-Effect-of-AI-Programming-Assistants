class Solution {
public:
    int minCapability(vector<int>& nums, int k) {
        int left = *min_element(nums.begin(), nums.end());
        int right = *max_element(nums.begin(), nums.end());

        auto canRob = [&](int cap) {
            int count = 0, n = nums.size();
            for (int i = 0; i < n; ) {
                if (nums[i] <= cap) {
                    count++;
                    i += 2; // skip the next house
                } else {
                    i++;
                }
            }
            return count >= k;
        };

        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canRob(mid)) right = mid;
            else left = mid + 1;
        }

        return left;
    }
};