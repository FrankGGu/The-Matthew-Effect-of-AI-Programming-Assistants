class Solution {
public:
    bool isSimilar(const string &a, const string &b) {
        int diff = 0;
        for (int i = 0; i < a.size(); ++i) {
            if (a[i] != b[i]) {
                diff++;
                if (diff > 2) return false;
            }
        }
        return diff == 0 || diff == 2;
    }

    int numSimilarGroups(vector<string>& strs) {
        int n = strs.size();
        vector<int> parent(n);
        for (int i = 0; i < n; ++i) parent[i] = i;

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (isSimilar(strs[i], strs[j])) {
                    int rootI = find(i);
                    int rootJ = find(j);
                    if (rootI != rootJ) {
                        parent[rootJ] = rootI;
                    }
                }
            }
        }

        int res = 0;
        for (int i = 0; i < n; ++i) {
            if (parent[i] == i) res++;
        }
        return res;
    }
};