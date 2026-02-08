class Solution {
public:
    string smallestEquivalentString(string s1, string s2, string baseStr) {
        vector<int> parent(26);
        iota(parent.begin(), parent.end(), 0);

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        for (int i = 0; i < s1.size(); ++i) {
            int root1 = find(s1[i] - 'a');
            int root2 = find(s2[i] - 'a');
            if (root1 != root2) {
                if (root1 < root2) {
                    parent[root2] = root1;
                } else {
                    parent[root1] = root2;
                }
            }
        }

        string result;
        for (char c : baseStr) {
            result += find(c - 'a') + 'a';
        }

        return result;
    }
};