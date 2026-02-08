#include <string>
#include <vector>

class Solution {
public:
    int strStr(std::string haystack, std::string needle) {
        int hLen = haystack.length();
        int nLen = needle.length();

        if (nLen == 0) {
            return 0;
        }

        if (hLen < nLen) {
            return -1;
        }

        for (int i = 0; i <= hLen - nLen; ++i) {
            int j;
            for (j = 0; j < nLen; ++j) {
                if (haystack[i + j] != needle[j]) {
                    break;
                }
            }
            if (j == nLen) {
                return i;
            }
        }

        return -1;
    }
};