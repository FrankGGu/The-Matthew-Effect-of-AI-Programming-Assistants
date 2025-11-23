#include <string>
#include <vector>
#include <algorithm>

class Solution {
public:
    std::string smallestSubsequence(std::string s) {
        std::vector<int> lastOccur(26, 0);
        for (int i = 0; i < s.length(); ++i) {
            lastOccur[s[i] - 'a'] = i;
        }

        std::string res = "";
        std::vector<bool> inStack(26, false);

        for (int i = 0; i < s.length(); ++i) {
            char currentChar = s[i];
            if (inStack[currentChar - 'a']) {
                continue;
            }

            while (!res.empty() && currentChar < res.back() && lastOccur[res.back() - 'a'] > i) {
                inStack[res.back() - 'a'] = false;
                res.pop_back();
            }

            res.push_back(currentChar);
            inStack[currentChar - 'a'] = true;
        }

        return res;
    }
};