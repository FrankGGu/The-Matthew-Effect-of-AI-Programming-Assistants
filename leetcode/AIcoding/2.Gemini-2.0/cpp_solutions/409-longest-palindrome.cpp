#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int longestPalindrome(string s) {
        vector<int> count(52, 0);
        for (char c : s) {
            if (c >= 'a' && c <= 'z') {
                count[c - 'a']++;
            } else {
                count[c - 'A' + 26]++;
            }
        }

        int length = 0;
        bool oddFound = false;
        for (int i = 0; i < 52; i++) {
            if (count[i] % 2 == 0) {
                length += count[i];
            } else {
                length += count[i] - 1;
                oddFound = true;
            }
        }

        if (oddFound) {
            length++;
        }

        return length;
    }
};