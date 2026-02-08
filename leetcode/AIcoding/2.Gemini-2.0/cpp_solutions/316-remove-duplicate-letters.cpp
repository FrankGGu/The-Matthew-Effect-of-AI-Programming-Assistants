#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    string removeDuplicateLetters(string s) {
        vector<int> count(26, 0);
        vector<bool> inStack(26, false);
        string stack = "";

        for (char c : s) {
            count[c - 'a']++;
        }

        for (char c : s) {
            count[c - 'a']--;

            if (inStack[c - 'a']) {
                continue;
            }

            while (!stack.empty() && c < stack.back() && count[stack.back() - 'a'] > 0) {
                inStack[stack.back() - 'a'] = false;
                stack.pop_back();
            }

            stack += c;
            inStack[c - 'a'] = true;
        }

        return stack;
    }
};