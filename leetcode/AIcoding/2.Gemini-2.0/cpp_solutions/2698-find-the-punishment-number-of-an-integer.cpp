#include <string>
#include <numeric>

using namespace std;

class Solution {
public:
    int punishmentNumber(int n) {
        int ans = 0;
        for (int i = 1; i <= n; ++i) {
            int sq = i * i;
            string s = to_string(sq);
            if (canPartition(s, 0, i)) {
                ans += sq;
            }
        }
        return ans;
    }

private:
    bool canPartition(const string& s, int start, int target) {
        if (start == s.size()) {
            return target == 0;
        }

        int sum = 0;
        for (int i = start; i < s.size(); ++i) {
            sum = sum * 10 + (s[i] - '0');
            if (sum > target) break;
            if (canPartition(s, i + 1, target - sum)) {
                return true;
            }
        }
        return false;
    }
};