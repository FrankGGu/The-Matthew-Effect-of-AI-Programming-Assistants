#include <string>

using namespace std;

class Solution {
public:
    string smallestString(string s) {
        int n = s.length();
        int start = -1;
        for (int i = 0; i < n; ++i) {
            if (s[i] != 'a') {
                start = i;
                break;
            }
        }

        if (start == -1) {
            s[n - 1] = 'z';
            return s;
        }

        int end = start;
        while (end < n && s[end] != 'a') {
            s[end]--;
            end++;
        }

        return s;
    }
};