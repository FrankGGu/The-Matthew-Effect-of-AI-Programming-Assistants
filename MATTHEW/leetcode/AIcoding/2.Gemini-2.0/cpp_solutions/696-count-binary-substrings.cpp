#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countBinarySubstrings(string s) {
        int prevRunLength = 0;
        int currRunLength = 1;
        int count = 0;

        for (int i = 1; i < s.length(); i++) {
            if (s[i] == s[i - 1]) {
                currRunLength++;
            } else {
                count += min(prevRunLength, currRunLength);
                prevRunLength = currRunLength;
                currRunLength = 1;
            }
        }

        count += min(prevRunLength, currRunLength);

        return count;
    }
};