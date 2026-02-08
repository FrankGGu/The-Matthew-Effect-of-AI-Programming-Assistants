#include <iostream>
#include <vector>
#include <cmath>

class Solution {
public:
    std::vector<int> shortestToChar(std::string s, char c) {
        int n = s.size();
        std::vector<int> result(n, 0);

        int prev = -n;
        for (int i = 0; i < n; ++i) {
            if (s[i] == c) {
                prev = i;
            }
            result[i] = i - prev;
        }

        prev = 2 * n;
        for (int i = n - 1; i >= 0; --i) {
            if (s[i] == c) {
                prev = i;
            }
            result[i] = std::min(result[i], prev - i);
        }

        return result;
    }
};