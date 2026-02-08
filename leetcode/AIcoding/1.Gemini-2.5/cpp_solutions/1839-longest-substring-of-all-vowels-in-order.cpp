#include <string>
#include <algorithm>
#include <vector>

class Solution {
public:
    int longestBeautifulSubstring(std::string word) {
        int n = word.length();
        if (n < 5) {
            return 0;
        }

        int maxLength = 0;
        int i = 0;
        while (i < n) {
            if (word[i] == 'a') {
                int j = i;
                int count = 1;
                while (j + 1 < n && word[j + 1] >= word[j]) {
                    if (word[j + 1] > word[j]) {
                        count++;
                    }
                    j++;
                }
                if (count == 5) {
                    maxLength = std::max(maxLength, j - i + 1);
                }
                i = j + 1;
            } else {
                i++;
            }
        }
        return maxLength;
    }
};