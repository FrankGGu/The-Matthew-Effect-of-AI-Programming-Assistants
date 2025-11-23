#include <string>
#include <algorithm>

class Solution {
public:
    int compareVersion(std::string version1, std::string version2) {
        int i = 0;
        int j = 0;
        int n1 = version1.length();
        int n2 = version2.length();

        while (i < n1 || j < n2) {
            long long num1 = 0;
            while (i < n1 && version1[i] != '.') {
                num1 = num1 * 10 + (version1[i] - '0');
                i++;
            }
            i++; // Move past the dot or past the end of the string

            long long num2 = 0;
            while (j < n2 && version2[j] != '.') {
                num2 = num2 * 10 + (version2[j] - '0');
                j++;
            }
            j++; // Move past the dot or past the end of the string

            if (num1 > num2) {
                return 1;
            }
            if (num1 < num2) {
                return -1;
            }
        }

        return 0;
    }
};