class Solution {
public:
    vector<int> getSubarrayBeauty(vector<int>& nums, int k, int x) {
        int n = nums.size();
        vector<int> result(n - k + 1);
        multiset<int> window;

        for (int i = 0; i < n; i++) {
            window.insert(nums[i]);
            if (i >= k) {
                window.erase(window.find(nums[i - k]));
            }
            if (i >= k - 1) {
                auto it = window.begin();
                advance(it, x - 1);
                result[i - k + 1] = (*it < 0) ? *it : 0;
            }
        }

        return result;
    }
};