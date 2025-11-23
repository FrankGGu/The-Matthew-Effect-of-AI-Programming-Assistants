class Solution {
public:
    vector<int> smallestSubarrays(vector<int>& nums) {
        int n = nums.size();
        vector<int> res(n, 1);
        vector<int> last(30, -1);

        for (int i = n - 1; i >= 0; --i) {
            for (int j = 0; j < 30; ++j) {
                if (nums[i] & (1 << j)) {
                    last[j] = i;
                } else if (last[j] != -1) {
                    res[i] = max(res[i], last[j] - i + 1);
                }
            }
        }

        return res;
    }
};