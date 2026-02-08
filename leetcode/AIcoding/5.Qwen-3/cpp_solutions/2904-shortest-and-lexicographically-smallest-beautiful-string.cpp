#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    string shortestBeautifulString(string s) {
        int n = s.size();
        vector<string> candidates;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (s[i] != s[j]) {
                    string candidate = s.substr(0, i) + s[j] + s.substr(i + 1, j - i - 1) + s[i] + s.substr(j + 1);
                    candidates.push_back(candidate);
                }
            }
        }

        if (candidates.empty()) {
            return "";
        }

        sort(candidates.begin(), candidates.end());
        return candidates[0];
    }
};