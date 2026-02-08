#include <iostream>
#include <vector>
#include <map>
#include <set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> accountsMerge(vector<vector<string>>& accounts) {
        map<string, string> parent;
        map<string, string> nameMap;

        function<string(string)> find = [&](string x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        function<void(string, string)> unionSet = [&](string x, string y) {
            string rootX = find(x);
            string rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
            }
        };

        for (auto& account : accounts) {
            string name = account[0];
            for (int i = 1; i < account.size(); ++i) {
                string email = account[i];
                nameMap[email] = name;
                if (parent.find(email) == parent.end()) {
                    parent[email] = email;
                }
                if (i > 1) {
                    unionSet(account[i], account[i - 1]);
                }
            }
        }

        map<string, set<string>> merged;
        for (auto& pair : nameMap) {
            string root = find(pair.first);
            merged[root].insert(pair.first);
        }

        vector<vector<string>> result;
        for (auto& pair : merged) {
            vector<string> emails(pair.second.begin(), pair.second.end());
            sort(emails.begin(), emails.end());
            result.push_back({nameMap[pair.first], emails});
        }

        return result;
    }
};