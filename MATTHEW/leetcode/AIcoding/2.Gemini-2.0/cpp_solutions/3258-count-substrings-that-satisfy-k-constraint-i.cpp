#include <string>

using namespace std;

class Solution {
public:
    int countSubstrings(string s, int k) {
        int n = s.length();
        int count = 0;
        for (int i = 0; i < n; ++i) {
            int distinctChars = 0;
            bool charSet[26] = {false};
            for (int j = i; j < n; ++j) {
                if (!charSet[s[j] - 'a']) {
                    charSet[s[j] - 'a'] = true;
                    distinctChars++;
                }
                if (distinctChars == k) {
                    count++;
                } else if (distinctChars > k) {
                    break;
                }
            }
        }
        return count;
    }
};