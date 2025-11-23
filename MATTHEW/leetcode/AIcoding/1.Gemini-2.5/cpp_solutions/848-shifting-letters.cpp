#include <string>
#include <vector>

class Solution {
public:
    std::string shiftingLetters(std::string s, std::vector<int>& shifts) {
        long long current_shift = 0;
        int n = s.length();
        for (int i = n - 1; i >= 0; --i) {
            current_shift = (current_shift + shifts[i]) % 26;
            s[i] = 'a' + (s[i] - 'a' + current_shift) % 26;
        }
        return s;
    }
};