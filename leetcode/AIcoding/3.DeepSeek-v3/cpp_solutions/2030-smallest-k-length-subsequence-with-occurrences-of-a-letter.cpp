class Solution {
public:
    string smallestSubsequence(string s, int k, char letter, int repetition) {
        int n = s.size();
        vector<int> cnt(n + 1, 0);
        for (int i = n - 1; i >= 0; --i) {
            cnt[i] = cnt[i + 1] + (s[i] == letter);
        }

        stack<char> st;
        for (int i = 0; i < n; ++i) {
            while (!st.empty() && st.top() > s[i] && (st.size() + n - i - 1) >= k) {
                if (st.top() == letter) {
                    if (cnt[i] + repetition - 1 < repetition) {
                        break;
                    }
                    repetition++;
                }
                st.pop();
            }
            if (st.size() < k) {
                if (s[i] == letter) {
                    st.push(s[i]);
                    repetition--;
                } else if (k - st.size() > repetition) {
                    st.push(s[i]);
                }
            }
        }

        string res;
        while (!st.empty()) {
            res += st.top();
            st.pop();
        }
        reverse(res.begin(), res.end());
        return res;
    }
};