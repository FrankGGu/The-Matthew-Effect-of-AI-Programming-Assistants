class Solution {
public:
    int find(vector<int>& parent, int i) {
        if (parent[i] == i)
            return i;
        return parent[i] = find(parent, parent[i]);
    }

    void unite(vector<int>& parent, int x, int y) {
        int rootX = find(parent, x);
        int rootY = find(parent, y);
        if (rootX != rootY)
            parent[rootX] = rootY;
    }

    bool equationsPossible(vector<string>& equations) {
        int n = 26;
        vector<int> parent(n);
        for (int i = 0; i < n; i++)
            parent[i] = i;

        for (string& eq : equations) {
            if (eq[1] == '=') {
                int x = eq[0] - 'a';
                int y = eq[3] - 'a';
                unite(parent, x, y);
            }
        }

        for (string& eq : equations) {
            if (eq[1] == '!') {
                int x = eq[0] - 'a';
                int y = eq[3] - 'a';
                if (find(parent, x) == find(parent, y))
                    return false;
            }
        }

        return true;
    }
};