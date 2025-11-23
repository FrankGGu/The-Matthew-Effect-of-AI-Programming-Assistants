#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int validPair(int n, string s) {
        int count = 0;
        vector<vector<bool>> seen(10, vector<bool>(10, false));
        for (int i = 0; i < s.length() - 1; ++i) {
            int digit1 = s[i] - '0';
            int digit2 = s[i + 1] - '0';
            if ((digit1 + digit2) % 2 == 0 && digit1 != digit2 && !seen[digit1][digit2]) {
                count++;
                seen[digit1][digit2] = true;
            }
        }
        return count;
    }
};