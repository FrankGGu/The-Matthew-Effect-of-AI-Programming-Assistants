#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool splitString(string s) {
        int n = s.size();
        function<bool(int, long long)> solve = [&](int idx, long long prev) {
            if (idx == n) {
                return true;
            }

            long long curr = 0;
            for (int i = idx; i < n; ++i) {
                curr = curr * 10 + (s[i] - '0');
                if (curr >= prev) continue;
                if (prev - curr == 1 && solve(i + 1, curr)) {
                    return true;
                }
                if (curr > (long long)1e10) break;
            }
            return false;
        };

        for (int i = 0; i < n - 1; ++i) {
            long long first = 0;
            for (int j = 0; j <= i; ++j) {
                first = first * 10 + (s[j] - '0');
            }

            if (solve(i + 1, first)) {
                return true;
            }
            if (first > (long long)1e10) break;
        }

        return false;
    }
};