#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

class Solution {
public:
    std::string getEncryptedString(const std::string& s, int k) {
        int n = s.size();
        std::string result;
        for (int i = 0; i < n; ++i) {
            result += s[(i + k) % n];
        }
        return result;
    }
};