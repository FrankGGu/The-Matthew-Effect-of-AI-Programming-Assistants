#include <vector>
#include <string>
#include <algorithm>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    string shortestSuperstring(vector<string>& A) {
        int n = A.size();
        vector<vector<int>> overlap(n, vector<int>(n, 0));
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                overlap[i][j] = getOverlap(A[i], A[j]);
            }
        }

        vector<vector<int>> dp(1 << n, vector<int>(n, INT_MAX));
        vector<vector<int>> parent(1 << n, vector<int>(n, -1));

        for (int i = 0; i < n; ++i) {
            dp[1 << i][i] = A[i].size();
        }

        for (int mask = 0; mask < (1 << n); ++mask) {
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) continue;
                for (int j = 0; j < n; ++j) {
                    if (mask & (1 << j)) continue;
                    int nextMask = mask | (1 << j);
                    int newLength = dp[mask][i] + A[j].size() - overlap[i][j];
                    if (newLength < dp[nextMask][j]) {
                        dp[nextMask][j] = newLength;
                        parent[nextMask][j] = i;
                    }
                }
            }
        }

        int minLength = INT_MAX;
        int lastIndex = -1;
        int finalMask = (1 << n) - 1;

        for (int i = 0; i < n; ++i) {
            if (dp[finalMask][i] < minLength) {
                minLength = dp[finalMask][i];
                lastIndex = i;
            }
        }

        string result = buildResult(A, parent, finalMask, lastIndex);
        return result;
    }

private:
    int getOverlap(const string& a, const string& b) {
        int maxOverlap = 0;
        int lenA = a.size(), lenB = b.size();
        for (int i = 1; i <= min(lenA, lenB); ++i) {
            if (a.substr(lenA - i) == b.substr(0, i)) {
                maxOverlap = i;
            }
        }
        return maxOverlap;
    }

    string buildResult(vector<string>& A, vector<vector<int>>& parent, int mask, int lastIndex) {
        string result;
        vector<bool> used(A.size(), false);
        while (lastIndex != -1) {
            used[lastIndex] = true;
            lastIndex = parent[mask][lastIndex];
            mask ^= (1 << lastIndex);
        }
        result += A[lastIndex];
        for (int i = 0; i < A.size(); ++i) {
            if (used[i]) continue;
            result += A[i];
        }
        return result;
    }
};