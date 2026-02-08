class Solution {
public:
    int numSimilarGroups(vector<string>& strs) {
        int n = strs.size();
        vector<int> parent(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto isSimilar = [&](const string& s1, const string& s2) {
            int diff = 0;
            for (int i = 0; i < s1.size(); ++i) {
                if (s1[i] != s2[i]) {
                    diff++;
                }
            }
            return diff == 0 || diff == 2;
        };

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (isSimilar(strs[i], strs[j])) {
                    int rootI = find(i);
                    int rootJ = find(j);
                    if (rootI != rootJ) {
                        parent[rootI] = rootJ;
                    }
                }
            }
        }

        int count = 0;
        for (int i = 0; i < n; ++i) {
            if (parent[i] == i) {
                count++;
            }
        }

        return count;
    }
};