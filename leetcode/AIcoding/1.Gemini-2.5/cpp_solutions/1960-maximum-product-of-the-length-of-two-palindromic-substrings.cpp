#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxProduct(string s) {
        int n = s.length();
        if (n < 2) {
            return 0;
        }

        vector<int> starts_at(n, 0);
        vector<int> ends_at(n, 0);

        for (int i = 0; i < n; ++i) {
            // Odd length palindromes
            int l = i, r = i;
            while (l >= 0 && r < n && s[l] == s[r]) {
                int len = r - l + 1;
                starts_at[l] = max(starts_at[l], len);
                ends_at[r] = max(ends_at[r], len);
                l--;
                r++;
            }

            // Even length palindromes
            l = i, r = i + 1;
            while (l >= 0 && r < n && s[l] == s[r]) {
                int len = r - l + 1;
                starts_at[l] = max(starts_at[l], len);
                ends_at[r] = max(ends_at[r], len);
                l--;
                r++;
            }
        }

        vector<int> left_max(n, 0);
        left_max[0] = ends_at[0];
        for (int i = 1; i < n; ++i) {
            left_max[i] = max(left_max[i - 1], ends_at[i]);
        }

        vector<int> right_max(n, 0);
        right_max[n - 1] = starts_at[n - 1];
        for (int i = n - 2; i >= 0; --i) {
            right_max[i] = max(right_max[i + 1], starts_at[i]);
        }

        long long max_prod = 0;
        for (int i = 0; i < n - 1; ++i) {
            max_prod = max(max_prod, (long long)left_max[i] * right_max[i + 1]);
        }

        return max_prod;
    }
};