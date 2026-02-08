class Solution {
public:
    int maxProduct(string s) {
        int n = s.size();
        int max_mask = 1 << n;
        vector<int> dp(max_mask, 0);

        for (int mask = 1; mask < max_mask; ++mask) {
            string sub;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    sub += s[i];
                }
            }
            if (isPalindrome(sub)) {
                dp[mask] = sub.size();
            }
        }

        int max_product = 0;
        for (int mask1 = 1; mask1 < max_mask; ++mask1) {
            if (dp[mask1] == 0) continue;
            for (int mask2 = mask1 + 1; mask2 < max_mask; ++mask2) {
                if (dp[mask2] == 0) continue;
                if ((mask1 & mask2) == 0) {
                    max_product = max(max_product, dp[mask1] * dp[mask2]);
                }
            }
        }

        return max_product;
    }

private:
    bool isPalindrome(const string& s) {
        int left = 0, right = s.size() - 1;
        while (left < right) {
            if (s[left] != s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
};