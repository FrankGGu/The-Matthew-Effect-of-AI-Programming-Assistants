#include <vector>

using namespace std;

class Solution {
public:
    int countArrangement(int n) {
        vector<bool> used(n + 1, false);
        int count = 0;
        solve(n, 1, used, count);
        return count;
    }

    void solve(int n, int pos, vector<bool>& used, int& count) {
        if (pos > n) {
            count++;
            return;
        }

        for (int i = 1; i <= n; ++i) {
            if (!used[i] && (i % pos == 0 || pos % i == 0)) {
                used[i] = true;
                solve(n, pos + 1, used, count);
                used[i] = false;
            }
        }
    }
};