class Solution {
public:
    string robotWithString(string s) {
        int n = s.size();
        vector<int> last(26, -1);
        for (int i = 0; i < n; ++i) {
            last[s[i] - 'a'] = i;
        }

        stack<char> st;
        string result;
        for (int i = 0; i < n; ++i) {
            st.push(s[i]);
            while (!st.empty()) {
                char c = st.top();
                bool canPop = true;
                for (char j = 'a'; j < c; ++j) {
                    if (last[j - 'a'] > i) {
                        canPop = false;
                        break;
                    }
                }
                if (canPop) {
                    result += c;
                    st.pop();
                } else {
                    break;
                }
            }
        }
        return result;
    }
};