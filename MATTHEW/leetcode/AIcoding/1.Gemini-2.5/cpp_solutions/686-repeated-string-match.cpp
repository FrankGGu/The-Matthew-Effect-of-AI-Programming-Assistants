#include <string>
#include <vector>

class Solution {
public:
    int repeatedStringMatch(std::string a, std::string b) {
        std::string s = a;
        int count = 1;
        while (s.length() < b.length()) {
            s += a;
            count++;
        }
        if (s.find(b) != std::string::npos) {
            return count;
        }
        s += a;
        if (s.find(b) != std::string::npos) {
            return count + 1;
        }
        return -1;
    }
};