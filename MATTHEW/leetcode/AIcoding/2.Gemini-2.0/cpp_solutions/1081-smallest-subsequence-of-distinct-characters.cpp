#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string smallestSubsequence(string s) {
        vector<int> last_occurrence(26, 0);
        for (int i = 0; i < s.size(); ++i) {
            last_occurrence[s[i] - 'a'] = i;
        }

        vector<bool> seen(26, false);
        string stack = "";

        for (int i = 0; i < s.size(); ++i) {
            int c = s[i] - 'a';
            if (seen[c]) continue;

            while (!stack.empty() && c < stack.back() - 'a' && i < last_occurrence[stack.back() - 'a']) {
                seen[stack.back() - 'a'] = false;
                stack.pop_back();
            }

            stack += (char)(c + 'a');
            seen[c] = true;
        }

        return stack;
    }
};