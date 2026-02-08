class Solution {
public:
    int findBestSubarray(vector<int>& nums, int k) {
        int n = nums.size();
        int best = INT_MAX;
        int closest = INT_MAX;

        for (int i = 0; i < n; ++i) {
            int curr_or = 0;
            for (int j = i; j < n; ++j) {
                curr_or |= nums[j];
                if (abs(curr_or - k) < abs(closest - k) || 
                   (abs(curr_or - k) == abs(closest - k) && curr_or < closest)) {
                    closest = curr_or;
                    best = j - i + 1;
                }
            }
        }

        return best;
    }
};