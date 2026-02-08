#include <string>

using namespace std;

class Solution {
public:
    string lastSubstring(string s) {
        int i = 0, j = 1, k = 0;
        int n = s.size();
        while (j + k < n) {
            if (s[i + k] == s[j + k]) {
                k++;
            } else if (s[i + k] < s[j + k]) {
                i = j;
                j++;
                k = 0;
            } else {
                j = j + k + 1;
                k = 0;
            }
        }
        return s.substr(i);
    }
};