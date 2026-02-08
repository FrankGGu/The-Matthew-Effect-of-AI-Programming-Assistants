#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxScore(string s) {
        int n = s.length();
        int max_score = 0;
        for (int i = 1; i < n; ++i) {
            int left_zeros = 0;
            for (int j = 0; j < i; ++j) {
                if (s[j] == '0') {
                    left_zeros++;
                }
            }
            int right_ones = 0;
            for (int j = i; j < n; ++j) {
                if (s[j] == '1') {
                    right_ones++;
                }
            }
            max_score = max(max_score, left_zeros + right_ones);
        }
        return max_score;
    }
};