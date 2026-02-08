class Solution {
public:
    vector<int> processQueries(vector<int>& queries, int m) {
        vector<int> P(m);
        for (int i = 0; i < m; ++i) {
            P[i] = i + 1;
        }
        vector<int> result;
        for (int query : queries) {
            int pos = 0;
            while (P[pos] != query) {
                ++pos;
            }
            result.push_back(pos);
            P.erase(P.begin() + pos);
            P.insert(P.begin(), query);
        }
        return result;
    }
};