#include <iostream>
#include <vector>
#include <string>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> moves;

    vector<int> findMoves(string s, string t) {
        int n = s.size();
        int m = t.size();
        vector<int> res;
        vector<bool> used(n, false);

        for (int i = 0; i < m; ++i) {
            if (t[i] != s[i]) {
                return {};
            }
        }

        for (int i = 0; i < n; ++i) {
            if (s[i] != t[i]) {
                return {};
            }
        }

        for (int i = n - 1; i >= 0; --i) {
            if (s[i] != t[i]) {
                int j = i;
                while (j >= 0 && s[j] == t[j]) {
                    --j;
                }
                if (j < 0) {
                    return {};
                }
                int len = i - j;
                for (int k = 0; k < len; ++k) {
                    s[j + k] = t[j + k];
                }
                res.push_back(j);
            }
        }

        return res;
    }

    vector<int> possibleMoves(string s, string t) {
        int n = s.size();
        int m = t.size();
        vector<int> res;
        for (int i = 0; i <= n - m; ++i) {
            bool match = true;
            for (int j = 0; j < m; ++j) {
                if (s[i + j] != t[j]) {
                    match = false;
                    break;
                }
            }
            if (match) {
                res.push_back(i);
            }
        }
        return res;
    }

    vector<int> movesToStamp(string s, string t) {
        int n = s.size();
        int m = t.size();
        vector<bool> visited(n, false);
        vector<int> result;

        while (true) {
            vector<int> candidates = possibleMoves(s, t);
            if (candidates.empty()) {
                break;
            }
            for (int idx : candidates) {
                for (int i = 0; i < m; ++i) {
                    if (s[idx + i] != t[i]) {
                        s[idx + i] = t[i];
                    }
                }
                result.push_back(idx);
                for (int i = 0; i < m; ++i) {
                    visited[idx + i] = true;
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                return {};
            }
        }

        return result;
    }
};