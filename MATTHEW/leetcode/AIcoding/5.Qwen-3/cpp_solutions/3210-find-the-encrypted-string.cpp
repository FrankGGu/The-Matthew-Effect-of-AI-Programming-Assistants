#include <iostream>
#include <string>

class Solution {
public:
    std::string getEncryptedString(std::string s, int k) {
        int n = s.length();
        std::string result;
        for (int i = 0; i < n; ++i) {
            int idx = (i + k) % n;
            result += s[idx];
        }
        return result;
    }
};