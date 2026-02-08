#include <string>
#include <algorithm> // Required for std::to_string and std::stoi

class Solution {
public:
    int monotoneIncreasingDigits(int n) {
        std::string s = std::to_string(n);
        int len = s.length();
        int marker = len;

        for (int i = len - 2; i >= 0; --i) {
            if (s[i] > s[i+1]) {
                s[i]--;
                marker = i + 1;
            }
        }

        for (int i = marker; i < len; ++i) {
            s[i] = '9';
        }

        return std::stoi(s);
    }
};