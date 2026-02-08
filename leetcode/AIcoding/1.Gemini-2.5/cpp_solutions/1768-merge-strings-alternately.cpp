#include <string>
#include <algorithm> // Required for std::min or similar, though not strictly needed for this approach.

class Solution {
public:
    std::string mergeAlternately(std::string word1, std::string word2) {
        std::string result = "";
        int i = 0;
        int j = 0;
        int n1 = word1.length();
        int n2 = word2.length();

        while (i < n1 || j < n2) {
            if (i < n1) {
                result += word1[i];
                i++;
            }
            if (j < n2) {
                result += word2[j];
                j++;
            }
        }
        return result;
    }
};