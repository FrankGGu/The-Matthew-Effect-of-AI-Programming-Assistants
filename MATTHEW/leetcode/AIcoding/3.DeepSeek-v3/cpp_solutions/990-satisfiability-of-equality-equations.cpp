class Solution {
public:
    int parent[26];

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootX] = rootY;
        }
    }

    bool equationsPossible(vector<string>& equations) {
        for (int i = 0; i < 26; ++i) {
            parent[i] = i;
        }

        for (const string& eq : equations) {
            if (eq[1] == '=') {
                int x = eq[0] - 'a';
                int y = eq[3] - 'a';
                unionSet(x, y);
            }
        }

        for (const string& eq : equations) {
            if (eq[1] == '!') {
                int x = eq[0] - 'a';
                int y = eq[3] - 'a';
                if (find(x) == find(y)) {
                    return false;
                }
            }
        }

        return true;
    }
};