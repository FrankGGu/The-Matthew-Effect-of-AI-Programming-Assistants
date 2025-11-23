class Solution {
public:
    vector<int> beautifulIndices(string s, string a, string b, int k) {
        vector<int> a_indices, b_indices;
        int n = s.size();
        int a_len = a.size();
        int b_len = b.size();

        // Find all indices where a occurs in s
        for (int i = 0; i <= n - a_len; ++i) {
            if (s.substr(i, a_len) == a) {
                a_indices.push_back(i);
            }
        }

        // Find all indices where b occurs in s
        for (int i = 0; i <= n - b_len; ++i) {
            if (s.substr(i, b_len) == b) {
                b_indices.push_back(i);
            }
        }

        vector<int> result;
        int a_ptr = 0, b_ptr = 0;
        int a_size = a_indices.size();
        int b_size = b_indices.size();

        // Check for each a index if there's a b index within k distance
        while (a_ptr < a_size && b_ptr < b_size) {
            int a_pos = a_indices[a_ptr];
            int b_pos = b_indices[b_ptr];

            if (abs(a_pos - b_pos) <= k) {
                result.push_back(a_pos);
                a_ptr++;
            } else if (a_pos < b_pos) {
                a_ptr++;
            } else {
                b_ptr++;
            }
        }

        return result;
    }
};