#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> accountsMerge(vector<vector<string>>& accounts) {
        unordered_map<string, string> emailToName;
        unordered_map<string, int> emailToId;
        int emailCount = 0;
        vector<vector<string>> adj;

        for (auto& account : accounts) {
            string name = account[0];
            for (int i = 1; i < account.size(); i++) {
                string email = account[i];
                emailToName[email] = name;
                if (emailToId.find(email) == emailToId.end()) {
                    emailToId[email] = emailCount++;
                    adj.emplace_back();
                }
                if (i > 1) {
                    adj[emailToId[account[i - 1]]].push_back(email);
                    adj[emailToId[email]].push_back(account[i - 1]);
                }
            }
        }

        vector<vector<string>> res;
        vector<bool> visited(emailCount, false);

        for (auto& [email, id] : emailToId) {
            if (!visited[id]) {
                vector<string> component;
                dfs(adj, visited, id, component, emailToId);
                sort(component.begin(), component.end());
                component.insert(component.begin(), emailToName[email]);
                res.push_back(component);
            }
        }

        return res;
    }

private:
    void dfs(vector<vector<string>>& adj, vector<bool>& visited, int id, vector<string>& component, unordered_map<string, int>& emailToId) {
        visited[id] = true;
        string email;
        for (auto& [e, i] : emailToId) {
            if (i == id) {
                email = e;
                break;
            }
        }

        component.push_back(email);

        for (string& neighbor : adj[id]) {
            int neighborId = emailToId[neighbor];
            if (!visited[neighborId]) {
                dfs(adj, visited, neighborId, component, emailToId);
            }
        }
    }
};