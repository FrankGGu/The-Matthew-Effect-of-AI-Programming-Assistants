#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int maximumRemovableElements(string s, string p, vector<int>& removable) {
        int n = s.length();
        int m = p.length();
        int k = removable.size();

        vector<bool> removed(n, false);

        for (int i = 0; i < k; ++i) {
            removed[removable[i]] = true;
        }

        int j = 0;
        for (int i = 0; i < n && j < m; ++i) {
            if (!removed[i] && s[i] == p[j]) {
                ++j;
            }
        }

        return j == m ? k : j;
    }
};