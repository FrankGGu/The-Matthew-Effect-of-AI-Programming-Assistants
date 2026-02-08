#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    long long numberOfSubstrings(std::string s) {
        long long count = 0;
        int last_a = -1;
        int last_b = -1;
        int last_c = -1;
        int n = s.length();

        for (int j = 0; j < n; ++j) {
            if (s[j] == 'a') {
                last_a = j;
            } else if (s[j] == 'b') {
                last_b = j;
            } else if (s[j] == 'c') {
                last_c = j;
            }

            if (last_a != -1 && last_b != -1 && last_c != -1) {
                count += (std::min({last_a, last_b, last_c}) + 1);
            }
        }

        return count;
    }
};