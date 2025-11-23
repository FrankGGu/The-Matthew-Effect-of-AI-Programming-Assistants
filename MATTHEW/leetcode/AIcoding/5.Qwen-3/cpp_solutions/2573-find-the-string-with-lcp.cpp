#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string findTheString(int n, int k, vector<vector<int>>& lcp) {
        vector<string> result(n, string(n, 'a'));

        for (int i = 0; i < n; ++i) {
            result[i][i] = 'a' + (i % k);
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (lcp[i][j] > 0) {
                    if (i == j) continue;
                    if (result[i][j] == 'a') {
                        result[i][j] = 'a' + (i % k);
                    }
                    if (result[j][i] == 'a') {
                        result[j][i] = 'a' + (i % k);
                    }
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (lcp[i][j] > 0) {
                    if (i != j && result[i][j] != result[j][i]) {
                        return "";
                    }
                }
            }
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (lcp[i][j] > 0) {
                    if (i + 1 < n && j + 1 < n && lcp[i][j] > 0) {
                        if (result[i][j] != result[i+1][j+1]) {
                            return "";
                        }
                    }
                }
            }
        }

        string ans;
        for (int i = 0; i < n; ++i) {
            ans += result[i][0];
        }
        return ans;
    }
};