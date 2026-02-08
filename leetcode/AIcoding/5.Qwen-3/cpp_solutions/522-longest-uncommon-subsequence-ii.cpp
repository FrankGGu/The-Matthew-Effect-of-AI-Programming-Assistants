#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findLUSlength(vector<string>& strs) {
        auto isSubsequence = [&](const string& a, const string& b) {
            int i = 0;
            for (int j = 0; i < a.size() && j < b.size(); ++j)
                if (a[i] == b[j]) ++i;
            return i == a.size();
        };

        for (int i = 0; i < strs.size(); ++i) {
            bool unique = true;
            for (int j = 0; j < strs.size(); ++j) {
                if (i != j && isSubsequence(strs[i], strs[j])) {
                    unique = false;
                    break;
                }
            }
            if (unique) return strs[i].size();
        }
        return -1;
    }
};