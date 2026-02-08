#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxPower(string s) {
        int max_len = 0;
        int curr_len = 0;
        char curr_char = '\0';

        for (char c : s) {
            if (c == curr_char) {
                curr_len++;
            } else {
                max_len = max(max_len, curr_len);
                curr_len = 1;
                curr_char = c;
            }
        }

        max_len = max(max_len, curr_len);

        return max_len;
    }
};