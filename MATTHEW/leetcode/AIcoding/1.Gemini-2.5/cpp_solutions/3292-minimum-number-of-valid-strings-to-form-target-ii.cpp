#include <vector>
#include <string>
#include <algorithm>
#include <cstring>

class Solution {
public:
    struct State {
        int len, link;
        int next[26];
    };
    std::vector<State> st;
    int sz, last;

    void sa_init(int max_states) {
        st.assign(max_states, State{});
        st[0].len = 0;
        st[0].link = -1;
        std::memset(st[0].next, -1, sizeof(st[0].next));
        sz = 1;
        last = 0;
    }

    void sa_extend(char c_char) {
        int c = c_char - 'a';
        int cur = sz++;
        st[cur].len = st[last].len + 1;
        std::memset(st[cur].next, -1, sizeof(st[cur].next));
        int p = last;
        while (p != -1 && st[p].next[c] == -1) {
            st[p].next[c] = cur;
            p = st[p].link;
        }
        if (p == -1) {
            st[cur].link = 0;
        } else {
            int q = st[p].next[c];
            if (st[q].len == st[p].len + 1) {
                st[cur].link = q;
            } else {
                int clone = sz++;
                st[clone].len = st[p].len + 1;
                std::memcpy(st[clone].next, st[q].next, sizeof(st[q].next));
                st[clone].link = st[q].link;
                while (p != -1 && st[p].next[c] == q) {
                    st[p].next[c] = clone;
                    p = st[p].link;
                }
                st[q].link = clone;
                st[cur].link = clone;
            }
        }
        last = cur;
    }

    int minimumStrings(std::vector<std::string>& words, std::string target) {
        int total_len = 0;
        for (const auto& w : words) {
            total_len += w.length();
        }

        sa_init(2 * total_len + 5);

        for (const std::string& word : words) {
            last = 0;
            for (char c : word) {
                sa_extend(c);
            }
        }

        int n = target.length();
        std::vector<int> dp(n + 1, n + 1);
        dp[0] = 0;

        for (int j = 0; j < n; ++j) {
            if (dp[j] > n) {
                continue;
            }
            int u = 0;
            for (int i = j; i < n; ++i) {
                int c = target[i] - 'a';
                if (st[u].next[c] == -1) {
                    break;
                }
                u = st[u].next[c];
                dp[i + 1] = std::min(dp[i + 1], dp[j] + 1);
            }
        }

        return dp[n] > n ? -1 : dp[n];
    }
};