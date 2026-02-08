#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> findLexSmallestSubsequence(string s, int k) {
        int n = s.size();
        vector<int> result;
        vector<int> indices;

        for (int i = 0; i < n; ++i) {
            indices.push_back(i);
        }

        sort(indices.begin(), indices.end(), [&](int a, int b) {
            return s[a] < s[b] || (s[a] == s[b] && a < b);
        });

        vector<bool> used(n, false);
        vector<int> res;

        for (int i = 0; i < k; ++i) {
            for (int j = 0; j < n; ++j) {
                if (!used[j]) {
                    res.push_back(s[j]);
                    used[j] = true;
                    break;
                }
            }
        }

        return res;
    }
};