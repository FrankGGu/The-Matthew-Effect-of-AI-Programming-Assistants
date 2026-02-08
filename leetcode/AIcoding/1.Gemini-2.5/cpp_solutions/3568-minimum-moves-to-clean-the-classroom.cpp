#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumMoves(std::string s, int m) {
        int operations = 0;
        int n = s.length();

        for (int i = 0; i < n; ++i) {
            if (s[i] == '0') {
                operations++;
                i += (m - 1); 
            }
        }
        return operations;
    }
};