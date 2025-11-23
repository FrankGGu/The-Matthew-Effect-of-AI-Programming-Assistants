#include <string>
#include <algorithm>
#include <vector>

using namespace std;

class Solution {
public:
    string makeSmallestPalindrome(string s) {
        vector<int> counts(26, 0);
        for (char c : s) {
            counts[c - 'a']++;
        }

        int oddCount = 0;
        int oddChar = -1;
        for (int i = 0; i < 26; i++) {
            if (counts[i] % 2 != 0) {
                oddCount++;
                oddChar = i;
            }
        }

        if (oddCount > 1) {
            return "";
        }

        string left = "";
        for (int i = 0; i < 26; i++) {
            left += string(counts[i] / 2, 'a' + i);
        }

        string right = left;
        reverse(right.begin(), right.end());

        string middle = "";
        if (oddChar != -1) {
            middle += string(1, 'a' + oddChar);
        }

        return left + middle + right;
    }
};