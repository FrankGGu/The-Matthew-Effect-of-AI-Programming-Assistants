#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestValidSubstring(string word, vector<string>& forbidden) {
        int n = word.size();
        int maxLength = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i; j < n; ++j) {
                string sub = word.substr(i, j - i + 1);
                bool isValid = true;
                for (const string& f : forbidden) {
                    if (sub.find(f) != string::npos) {
                        isValid = false;
                        break;
                    }
                }
                if (isValid) {
                    maxLength = max(maxLength, (int)sub.size());
                }
            }
        }
        return maxLength;
    }
};