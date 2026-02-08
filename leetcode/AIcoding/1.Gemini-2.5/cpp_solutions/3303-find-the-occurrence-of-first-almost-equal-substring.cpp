#include <string>
#include <vector>

class Solution {
public:
    int firstAlmostEqualSubstring(std::string s1, std::string s2) {
        int n = s1.length();
        int m = s2.length();

        if (n < m) {
            return -1;
        }

        for (int i = 0; i <= n - m; ++i) {
            int diff_count = 0;
            for (int j = 0; j < m; ++j) {
                if (s1[i + j] != s2[j]) {
                    diff_count++;
                }
                if (diff_count > 1) {
                    break;
                }
            }
            if (diff_count <= 1) {
                return i;
            }
        }

        return -1;
    }
};