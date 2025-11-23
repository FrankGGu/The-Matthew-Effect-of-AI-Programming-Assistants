#include <string>

class Solution {
public:
    std::string generateTheString(int n) {
        if (n % 2 == 1) {
            return std::string(n, 'a');
        } else {
            return std::string(n - 1, 'a') + 'b';
        }
    }
};