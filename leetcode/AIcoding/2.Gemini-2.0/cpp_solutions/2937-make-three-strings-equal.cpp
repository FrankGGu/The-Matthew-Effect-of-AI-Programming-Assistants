#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMinimumOperations(string s1, string s2, string s3) {
        int n1 = s1.length();
        int n2 = s2.length();
        int n3 = s3.length();

        int commonLength = 0;
        for (int i = 0; i < min({n1, n2, n3}); ++i) {
            if (s1[i] == s2[i] && s2[i] == s3[i]) {
                commonLength++;
            } else {
                break;
            }
        }

        if (commonLength == 0) {
            return n1 + n2 + n3;
        }

        return n1 + n2 + n3 - 3 * commonLength;
    }
};