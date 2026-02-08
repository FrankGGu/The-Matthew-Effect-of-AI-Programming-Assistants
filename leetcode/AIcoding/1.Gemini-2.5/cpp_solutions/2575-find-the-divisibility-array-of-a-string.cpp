#include <vector>
#include <string>

class Solution {
public:
    std::vector<int> divisibilityArray(std::string word, int m) {
        int n = word.length();
        std::vector<int> div(n);
        long long current_rem = 0;
        for (int i = 0; i < n; ++i) {
            int digit = word[i] - '0';
            current_rem = (current_rem * 10 + digit) % m;
            if (current_rem == 0) {
                div[i] = 1;
            } else {
                div[i] = 0;
            }
        }
        return div;
    }
};