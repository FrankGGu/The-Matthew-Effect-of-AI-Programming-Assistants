#include <iostream>
#include <vector>
#include <string>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int maxLength(vector<string>& arr) {
        vector<unordered_set<char>> validStrings;
        for (const string& s : arr) {
            unordered_set<char> uniqueChars(s.begin(), s.end());
            if (uniqueChars.size() == s.length()) {
                validStrings.push_back(uniqueChars);
            }
        }

        int maxLen = 0;
        dfs(validStrings, 0, {}, maxLen);
        return maxLen;
    }

private:
    void dfs(const vector<unordered_set<char>>& validStrings, int start, unordered_set<char> current, int& maxLen) {
        maxLen = max(maxLen, static_cast<int>(current.size()));
        for (int i = start; i < validStrings.size(); ++i) {
            bool canAdd = true;
            for (char c : validStrings[i]) {
                if (current.find(c) != current.end()) {
                    canAdd = false;
                    break;
                }
            }
            if (canAdd) {
                for (char c : validStrings[i]) {
                    current.insert(c);
                }
                dfs(validStrings, i + 1, current, maxLen);
                for (char c : validStrings[i]) {
                    current.erase(c);
                }
            }
        }
    }
};