#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int getMaxRepetitions(string s1, int n1, string s2, int n2) {
        int len1 = s1.length();
        int len2 = s2.length();

        if (len1 == 0 || len2 == 0 || n1 == 0 || n2 == 0) {
            return 0;
        }

        vector<int> repeatCount(len2 + 1, 0);
        vector<int> nextIndex(len2 + 1, 0);

        int j = 0, count = 0;
        for (int k = 1; k <= n1; ++k) {
            for (int i = 0; i < len1; ++i) {
                if (s1[i] == s2[j]) {
                    ++j;
                    if (j == len2) {
                        ++count;
                        j = 0;
                    }
                }
            }
            repeatCount[k] = count;
            nextIndex[k] = j;

            for (int start = 0; start < k; ++start) {
                if (nextIndex[start] == j) {
                    int prefixCount = repeatCount[start];
                    int patternCount = (repeatCount[k] - repeatCount[start]) * ((n1 - start) / (k - start));
                    int suffixCount = repeatCount[start + (n1 - start) % (k - start)] - repeatCount[start];
                    return (prefixCount + patternCount + suffixCount) / n2;
                }
            }
        }

        return repeatCount[n1] / n2;
    }
};