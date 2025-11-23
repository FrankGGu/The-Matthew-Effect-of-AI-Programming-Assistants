#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    int numSplits(std::string s) {
        int n = s.length();
        if (n <= 1) {
            return 0;
        }

        std::vector<int> left_unique(n);
        std::vector<int> right_unique(n);

        std::vector<int> freq_left(26, 0);
        int distinct_count_left = 0;
        for (int i = 0; i < n; ++i) {
            if (freq_left[s[i] - 'a'] == 0) {
                distinct_count_left++;
            }
            freq_left[s[i] - 'a']++;
            left_unique[i] = distinct_count_left;
        }

        std::vector<int> freq_right(26, 0);
        int distinct_count_right = 0;
        for (int i = n - 1; i >= 0; --i) {
            if (freq_right[s[i] - 'a'] == 0) {
                distinct_count_right++;
            }
            freq_right[s[i] - 'a']++;
            right_unique[i] = distinct_count_right;
        }

        int good_splits = 0;
        for (int i = 0; i < n - 1; ++i) {
            if (left_unique[i] == right_unique[i + 1]) {
                good_splits++;
            }
        }

        return good_splits;
    }
};