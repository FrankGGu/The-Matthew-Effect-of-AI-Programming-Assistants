class Solution {
public:
    vector<int> beautifulIndices(string s, string a, string b, int k) {
        vector<int> res;
        vector<int> a_indices, b_indices;
        int n = s.size();
        int a_len = a.size();
        int b_len = b.size();

        for (int i = 0; i <= n - a_len; ++i) {
            if (s.substr(i, a_len) == a) {
                a_indices.push_back(i);
            }
        }

        for (int i = 0; i <= n - b_len; ++i) {
            if (s.substr(i, b_len) == b) {
                b_indices.push_back(i);
            }
        }

        for (int i : a_indices) {
            auto it = lower_bound(b_indices.begin(), b_indices.end(), i - k);
            if (it != b_indices.end() && abs(*it - i) <= k) {
                res.push_back(i);
                continue;
            }
            if (it != b_indices.begin()) {
                --it;
                if (abs(*it - i) <= k) {
                    res.push_back(i);
                }
            }
        }

        return res;
    }
};