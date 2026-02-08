#include <iostream>
#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string removeDuplicateLetters(string s) {
        vector<int> last(26, 0);
        vector<bool> seen(26, false);
        string result = "";

        for (int i = 0; i < s.length(); ++i) {
            last[s[i] - 'a'] = i;
        }

        for (int i = 0; i < s.length(); ++i) {
            int c = s[i] - 'a';
            if (seen[c]) continue;

            while (!result.empty() && c < result.back() - 'a' && i < last[result.back() - 'a']) {
                seen[result.back() - 'a'] = false;
                result.pop_back();
            }

            result += s[i];
            seen[c] = true;
        }

        return result;
    }
};