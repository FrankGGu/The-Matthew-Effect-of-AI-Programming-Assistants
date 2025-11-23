class Solution {
public:
    vector<bool> canMakePalindromeQueries(string s, vector<vector<int>>& queries) {
        int n = s.size();
        string t = s;
        reverse(t.begin(), t.end());
        if (s == t) {
            return vector<bool>(queries.size(), true);
        }

        vector<int> diff(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            diff[i + 1] = diff[i] + (s[i] != t[i] ? 1 : 0);
        }

        vector<vector<int>> freq_s(n + 1, vector<int>(26, 0));
        vector<vector<int>> freq_t(n + 1, vector<int>(26, 0));
        for (int i = 0; i < n; ++i) {
            for (int c = 0; c < 26; ++c) {
                freq_s[i + 1][c] = freq_s[i][c];
                freq_t[i + 1][c] = freq_t[i][c];
            }
            freq_s[i + 1][s[i] - 'a']++;
            freq_t[i + 1][t[i] - 'a']++;
        }

        vector<bool> res;
        for (auto& q : queries) {
            int a = q[0], b = q[1], c = n - 1 - q[3], d = n - 1 - q[2];
            if (a > d || c > b) {
                if (diff[a] + (diff[n] - diff[max(b, d) + 1]) + (d >= a ? diff[d + 1] - diff[a] : 0) + (b >= c ? diff[b + 1] - diff[c] : 0) == 0) {
                    bool ok = true;
                    for (int i = 0; i < 26; ++i) {
                        if (freq_s[b + 1][i] - freq_s[a][i] != freq_t[d + 1][i] - freq_t[c][i]) {
                            ok = false;
                            break;
                        }
                    }
                    res.push_back(ok);
                } else {
                    res.push_back(false);
                }
            } else {
                int left = min(a, c);
                int right = max(b, d);
                if (diff[left] + (diff[n] - diff[right + 1]) == 0) {
                    bool ok = true;
                    for (int i = 0; i < 26; ++i) {
                        int s1 = freq_s[b + 1][i] - freq_s[a][i];
                        int t1 = freq_t[d + 1][i] - freq_t[c][i];
                        int s2 = freq_s[right + 1][i] - freq_s[left][i];
                        int t2 = freq_t[right + 1][i] - freq_t[left][i];
                        if (s1 + t1 != s2 || s1 + t1 != t2) {
                            ok = false;
                            break;
                        }
                    }
                    res.push_back(ok);
                } else {
                    res.push_back(false);
                }
            }
        }
        return res;
    }
};