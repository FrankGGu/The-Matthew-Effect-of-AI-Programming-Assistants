#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int strTransform(string s, string t, int k) {
        if (s.length() != t.length()) return -1;
        int n = s.length();
        unordered_map<char, vector<int>> pos;
        for (int i = 0; i < n; ++i) {
            pos[s[i]].push_back(i);
        }
        vector<int> res(n, -1);
        for (int i = 0; i < n; ++i) {
            if (s[i] == t[i]) continue;
            if (pos[t[i]].empty()) return -1;
            int j = pos[t[i]].back();
            pos[t[i]].pop_back();
            res[i] = j;
        }
        int cnt = 0;
        for (int i = 0; i < n; ++i) {
            if (res[i] != -1) {
                if (res[res[i]] == i) {
                    cnt++;
                }
            }
        }
        return cnt <= k ? 1 : -1;
    }
};