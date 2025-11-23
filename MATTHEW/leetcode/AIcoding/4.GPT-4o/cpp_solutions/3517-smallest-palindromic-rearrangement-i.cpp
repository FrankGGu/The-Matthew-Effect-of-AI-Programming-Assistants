#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string smallestPalindromic(std::string n) {
        std::vector<int> count(10, 0);
        for (char c : n) {
            count[c - '0']++;
        }

        std::string half = "";
        char middle = '0';
        for (int i = 0; i < 10; i++) {
            if (count[i] % 2 == 1 && (middle == '0' || i < middle - '0')) {
                middle = i + '0';
            }
            half += std::string(count[i] / 2, i + '0');
        }

        if (half.empty() || (half == "0" && middle == '0')) {
            return "0";
        }

        std::string firstHalf = half;
        std::reverse(half.begin(), half.end());
        return (middle == '0' ? firstHalf : firstHalf + middle + half);
    }
};