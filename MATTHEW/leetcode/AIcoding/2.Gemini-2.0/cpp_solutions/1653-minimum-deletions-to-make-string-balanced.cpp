#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDeletions(string s) {
        int n = s.length();
        int b_count = 0;
        int deletions = 0;

        for (int i = 0; i < n; ++i) {
            if (s[i] == 'b') {
                b_count++;
            } else {
                if (b_count > 0) {
                    deletions = min(deletions + 1, b_count);
                }
            }
        }

        return deletions;
    }
};