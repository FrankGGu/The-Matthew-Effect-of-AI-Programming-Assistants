#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool splitString(string s) {
        function<bool(int, long long)> solve = [&](int idx, long long prev) {
            if (idx == s.size()) {
                return true;
            }

            long long currentNum = 0;
            for (int i = idx; i < s.size(); ++i) {
                currentNum = currentNum * 10 + (s[i] - '0');
                if (currentNum >= 1e12) break;

                if (idx == 0 || currentNum == prev - 1) {
                    if (solve(i + 1, currentNum)) {
                        return true;
                    }
                }
            }
            return false;
        };

        return solve(0, 0);
    }
};