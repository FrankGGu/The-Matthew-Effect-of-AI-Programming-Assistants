#include <string>
#include <climits>

using namespace std;

class Solution {
public:
    string smallestSubstring(string s) {
        if (s.empty()) return "";
        int n = s.size();
        int min_len = INT_MAX;
        string result = "";

        for (int i = 0; i < n; ) {
            char current = s[i];
            int j = i;
            while (j < n && s[j] == current) {
                j++;
            }
            int len = j - i;
            if (len < min_len || (len == min_len && s.substr(i, len) < result)) {
                min_len = len;
                result = s.substr(i, len);
            }
            i = j;
        }

        return result;
    }
};