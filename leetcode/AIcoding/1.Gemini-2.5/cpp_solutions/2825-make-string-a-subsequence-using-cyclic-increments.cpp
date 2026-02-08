#include <string>
#include <vector>

class Solution {
public:
    bool canMakeSubsequence(std::string str1, std::string str2) {
        int i = 0, j = 0;
        int n1 = str1.length();
        int n2 = str2.length();

        while (i < n1 && j < n2) {
            char c1 = str1[i];
            char c2 = str2[j];

            char next_c1 = (c1 == 'z') ? 'a' : c1 + 1;

            if (c1 == c2 || next_c1 == c2) {
                j++;
            }
            i++;
        }

        return j == n2;
    }
};