class Solution {
public:
    vector<vector<string>> accountsMerge(vector<vector<string>>& accounts) {
        unordered_map<string, string> emailToName;
        unordered_map<string, vector<string>> graph;

        for (const auto& account : accounts) {
            string name = account[0];
            for (int i = 1; i < account.size(); ++i) {
                emailToName[account[i]] = name;
                graph[account[i]].push_back(account[1]);
                graph[account[1]].push_back(account[i]);
            }
        }

        unordered_set<string> visited;
        vector<vector<string>> result;

        for (const auto& account : accounts) {
            if (visited.count(account[1]) == 0) {
                vector<string> emails;
                dfs(account[1], graph, visited, emails);
                sort(emails.begin(), emails.end());
                emails.insert(emails.begin(), emailToName[emails[0]]);
                result.push_back(emails);
            }
        }

        return result;
    }

private:
    void dfs(const string& email, unordered_map<string, vector<string>>& graph, unordered_set<string>& visited, vector<string>& emails) {
        visited.insert(email);
        emails.push_back(email);
        for (const auto& neighbor : graph[email]) {
            if (!visited.count(neighbor)) {
                dfs(neighbor, graph, visited, emails);
            }
        }
    }
};