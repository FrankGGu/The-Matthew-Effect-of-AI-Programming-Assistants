class Solution {
public:
    vector<string> findLCP(vector<string>& strings) {
        int n = strings.size();
        vector<string> result(n);
        for (int i = 0; i < n; ++i) {
            string& s = strings[i];
            string lcp = s;
            for (int j = 0; j < n; ++j) {
                if (i != j) {
                    int k = 0;
                    while (k < lcp.size() && k < strings[j].size() && lcp[k] == strings[j][k]) {
                        ++k;
                    }
                    lcp = lcp.substr(0, k);
                }
            }
            result[i] = lcp;
        }
        return result;
    }
};