#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    int minimumOperations(string num) {
        int n = num.length();
        int ans = n;

        bool has_zero = false;
        for (char c : num) {
            if (c == '0') {
                has_zero = true;
                break;
            }
        }

        if (has_zero) {
            ans = n - 1;
        }

        for (int i = n - 1; i >= 0; --i) {
            if (num[i] == '0') {
                for (int j = i - 1; j >= 0; --j) {
                    if (num[j] == '0' || num[j] == '5') {
                        ans = std::min(ans, n - j - 2);
                        break;
                    }
                }
            } else if (num[i] == '5') {
                for (int j = i - 1; j >= 0; --j) {
                    if (num[j] == '2' || num[j] == '7') {
                        ans = std::min(ans, n - j - 2);
                        break;
                    }
                }
            }
        }

        return ans;
    }
};