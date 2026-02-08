#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minMovesToMakePalindrome(string s) {
        int n = s.length();
        int moves = 0;
        for (int i = 0; i < n / 2; ++i) {
            int l = i;
            int r = n - 1 - i;
            while (l < r) {
                if (s[l] == s[r]) {
                    break;
                }
                r--;
            }
            if (l == r) {
                moves += n / 2 - i;
                for (int j = i; j < n / 2; ++j) {
                    swap(s[j], s[j + 1]);
                }
            } else {
                moves += n - 1 - i - r;
                for (int j = r; j < n - 1 - i; ++j) {
                    swap(s[j], s[j + 1]);
                }
            }
        }
        return moves;
    }
};