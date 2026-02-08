#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int findFirstOccurrence(string s, string t) {
        int n = s.length();
        int m = t.length();

        if (m > n) {
            return -1;
        }

        for (int i = 0; i <= n - m; ++i) {
            int diff = 0;
            for (int j = 0; j < m; ++j) {
                if (s[i + j] != t[j]) {
                    diff++;
                }
            }
            if (diff <= 1) {
                return i;
            }
        }

        return -1;
    }
};