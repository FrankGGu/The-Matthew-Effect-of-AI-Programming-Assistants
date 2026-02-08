#include <string>
#include <unordered_map>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string smallestPalindromic(std::string num) {
        std::unordered_map<char, int> count;
        for (char c : num) {
            count[c]++;
        }

        std::string half = "", odd = "";
        for (char c = '1'; c <= '9'; ++c) {
            if (count[c] > 0) {
                half += std::string(count[c] / 2, c);
                if (count[c] % 2 == 1) {
                    if (odd.empty() || c < odd[0]) {
                        odd = c;
                    }
                }
                count[c] = 0;
            }
        }

        if (half.empty() && odd.empty()) return "0";

        std::string result = half;
        if (!odd.empty()) {
            result += odd;
        }
        std::reverse(half.begin(), half.end());
        result += half;

        return result;
    }
};