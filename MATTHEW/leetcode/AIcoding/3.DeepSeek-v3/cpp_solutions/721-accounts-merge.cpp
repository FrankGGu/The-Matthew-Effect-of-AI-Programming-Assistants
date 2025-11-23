class UnionFind {
public:
    UnionFind(int n) : parent(n) {
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unite(int x, int y) {
        parent[find(x)] = find(y);
    }

private:
    vector<int> parent;
};

class Solution {
public:
    vector<vector<string>> accountsMerge(vector<vector<string>>& accounts) {
        unordered_map<string, int> emailToIndex;
        unordered_map<int, string> indexToName;
        int n = accounts.size();
        UnionFind uf(n);

        for (int i = 0; i < n; ++i) {
            string name = accounts[i][0];
            indexToName[i] = name;
            for (int j = 1; j < accounts[i].size(); ++j) {
                string email = accounts[i][j];
                if (emailToIndex.find(email) == emailToIndex.end()) {
                    emailToIndex[email] = i;
                } else {
                    uf.unite(i, emailToIndex[email]);
                }
            }
        }

        unordered_map<int, set<string>> mergedEmails;
        for (auto& [email, index] : emailToIndex) {
            int root = uf.find(index);
            mergedEmails[root].insert(email);
        }

        vector<vector<string>> result;
        for (auto& [index, emails] : mergedEmails) {
            vector<string> account;
            account.push_back(indexToName[index]);
            account.insert(account.end(), emails.begin(), emails.end());
            result.push_back(account);
        }

        return result;
    }
};