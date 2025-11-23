class Solution {
public:
    string minInteger(string num, int k) {
        int n = num.size();
        vector<int> pos(10, -1);
        for (int i = 0; i < n; ++i) {
            int d = num[i] - '0';
            if (pos[d] == -1) pos[d] = i;
        }

        string res;
        vector<bool> used(n, false);

        for (int i = 0; i < n; ++i) {
            if (used[i]) continue;
            for (int d = 0; d < 10; ++d) {
                if (pos[d] == -1) continue;
                int j = pos[d];
                int cnt = 0;
                for (int l = 0; l < j; ++l) {
                    if (!used[l]) ++cnt;
                }
                if (cnt <= k) {
                    k -= cnt;
                    res += num[j];
                    used[j] = true;
                    while (pos[d] < n && (used[pos[d]] || num[pos[d]] - '0' != d)) {
                        ++pos[d];
                    }
                    if (pos[d] >= n) pos[d] = -1;
                    break;
                }
            }
        }

        return res;
    }
};