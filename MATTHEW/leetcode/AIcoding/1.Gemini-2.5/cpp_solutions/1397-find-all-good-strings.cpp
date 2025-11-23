#include <vector>
#include <string>
#include <cstring>

using namespace std;

class Solution {
public:
    int findGoodStrings(int n, string s1, string s2, string evil) {
        this->n = n;
        this->evil = evil;

        computeKMPAutomaton();

        int count_s2 = count(s2);
        int count_s1 = count(s1);

        int result = (count_s2 - count_s1 + MOD) % MOD;

        if (s1.find(evil) == string::npos) {
            result = (result + 1) % MOD;
        }

        return result;
    }

private:
    int n;
    string evil;
    vector<vector<int>> kmp_trans;
    int memo[501][51][2];
    const int MOD = 1e9 + 7;

    void computeKMPAutomaton() {
        int m = evil.length();
        vector<int> lps(m, 0);
        for (int i = 1, length = 0; i < m; ) {
            if (evil[i] == evil[length]) {
                length++;
                lps[i] = length;
                i++;
            } else {
                if (length != 0) {
                    length = lps[length - 1];
                } else {
                    lps[i] = 0;
                    i++;
                }
            }
        }

        kmp_trans.assign(m, vector<int>(26));
        for (int j = 0; j < m; ++j) {
            for (int c_val = 0; c_val < 26; ++c_val) {
                char c = 'a' + c_val;
                if (c == evil[j]) {
                    kmp_trans[j][c_val] = j + 1;
                } else {
                    if (j > 0) {
                        kmp_trans[j][c_val] = kmp_trans[lps[j - 1]][c_val];
                    } else {
                        kmp_trans[j][c_val] = (c == evil[0] ? 1 : 0);
                    }
                }
            }
        }
    }

    int dp(int index, int evil_match_len, bool is_tight, const string& upper_bound) {
        if (evil_match_len == evil.length()) {
            return 0;
        }
        if (index == n) {
            return 1;
        }
        if (memo[index][evil_match_len][is_tight] != -1) {
            return memo[index][evil_match_len][is_tight];
        }

        long long ans = 0;
        char limit = is_tight ? upper_bound[index] : 'z';

        for (char c = 'a'; c <= limit; ++c) {
            int next_evil_match_len = kmp_trans[evil_match_len][c - 'a'];
            bool new_is_tight = is_tight && (c == limit);
            ans = (ans + dp(index + 1, next_evil_match_len, new_is_tight, upper_bound)) % MOD;
        }

        return memo[index][evil_match_len][is_tight] = ans;
    }

    int count(const string& s) {
        memset(memo, -1, sizeof(memo));
        return dp(0, 0, true, s);
    }
};