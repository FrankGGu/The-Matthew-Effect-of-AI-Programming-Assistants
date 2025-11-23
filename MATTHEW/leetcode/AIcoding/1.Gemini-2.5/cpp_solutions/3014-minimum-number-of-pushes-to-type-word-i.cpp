#include <string>

class Solution {
public:
    int minimumPushes(std::string word) {
        int n = word.length();
        if (n <= 8) {
            return n;
        }
        if (n <= 16) {
            return 8 * 1 + (n - 8) * 2;
        }
        if (n <= 24) {
            return 8 * 1 + 8 * 2 + (n - 16) * 3;
        }
        return 8 * 1 + 8 * 2 + 8 * 3 + (n - 24) * 4;
    }
};