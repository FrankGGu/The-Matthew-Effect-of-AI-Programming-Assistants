class Solution {
public:
    int countMatchingSubarrays(vector<int>& nums, vector<int>& pattern) {
        int n = nums.size();
        int m = pattern.size();
        if (n <= m) return 0;

        vector<int> nums_pattern(n - 1);
        for (int i = 0; i < n - 1; ++i) {
            if (nums[i + 1] > nums[i]) {
                nums_pattern[i] = 1;
            } else if (nums[i + 1] == nums[i]) {
                nums_pattern[i] = 0;
            } else {
                nums_pattern[i] = -1;
            }
        }

        vector<int> lps(m, 0);
        int len = 0;
        int i = 1;
        while (i < m) {
            if (pattern[i] == pattern[len]) {
                len++;
                lps[i] = len;
                i++;
            } else {
                if (len != 0) {
                    len = lps[len - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }

        int res = 0;
        i = 0;
        int j = 0;
        while (i < nums_pattern.size()) {
            if (nums_pattern[i] == pattern[j]) {
                i++;
                j++;
                if (j == m) {
                    res++;
                    j = lps[j - 1];
                }
            } else {
                if (j != 0) {
                    j = lps[j - 1];
                } else {
                    i++;
                }
            }
        }
        return res;
    }
};