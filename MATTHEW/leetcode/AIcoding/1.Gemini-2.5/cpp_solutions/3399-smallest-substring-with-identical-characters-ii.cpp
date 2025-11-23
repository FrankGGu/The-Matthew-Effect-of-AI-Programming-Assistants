#include <string>
#include <algorithm>
#include <limits>

class Solution {
public:
    int smallestSubstringWithIdenticalCharacters(std::string s, int k) {
        int n = s.length();
        if (n == 0) {
            return -1;
        }

        int minLength = std::numeric_limits<int>::max();

        for (int i = 0; i < n; ) {
            char currentChar = s[i];
            int currentRunLength = 0;
            int j = i;

            while (j < n && s[j] == currentChar) {
                currentRunLength++;
                j++;
            }

            if (currentRunLength >= k) {
                minLength = std::min(minLength, currentRunLength);
            }

            i = j;
        }

        if (minLength == std::numeric_limits<int>::max()) {
            return -1;
        } else {
            return minLength;
        }
    }
};