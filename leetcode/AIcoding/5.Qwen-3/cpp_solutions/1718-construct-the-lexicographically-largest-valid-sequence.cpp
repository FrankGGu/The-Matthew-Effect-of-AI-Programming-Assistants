#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> res;
    vector<bool> used;

    bool backtrack(int n, int pos, vector<int>& curr) {
        if (pos > n) {
            res = curr;
            return true;
        }
        for (int i = 1; i <= n; ++i) {
            if (!used[i]) {
                if (pos == 1 || (curr[pos - 2] + i) % 2 == 0) {
                    used[i] = true;
                    curr[pos - 1] = i;
                    if (backtrack(n, pos + 1, curr)) {
                        return true;
                    }
                    used[i] = false;
                }
            }
        }
        return false;
    }

    vector<int> constructLargeSeq(int n) {
        res.clear();
        used.assign(n + 1, false);
        vector<int> curr(n, 0);
        backtrack(n, 1, curr);
        return res;
    }
};