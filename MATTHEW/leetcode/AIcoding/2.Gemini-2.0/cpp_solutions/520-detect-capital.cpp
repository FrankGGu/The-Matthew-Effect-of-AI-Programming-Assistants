#include <string>

using namespace std;

class Solution {
public:
    bool detectCapitalUse(string word) {
        int n = word.length();
        if (n == 0) return true;

        if (n == 1) return true;

        if (isupper(word[0])) {
            if (isupper(word[1])) {
                for (int i = 2; i < n; ++i) {
                    if (islower(word[i])) return false;
                }
            } else {
                for (int i = 2; i < n; ++i) {
                    if (isupper(word[i])) return false;
                }
            }
        } else {
            for (int i = 1; i < n; ++i) {
                if (isupper(word[i])) return false;
            }
        }

        return true;
    }
};