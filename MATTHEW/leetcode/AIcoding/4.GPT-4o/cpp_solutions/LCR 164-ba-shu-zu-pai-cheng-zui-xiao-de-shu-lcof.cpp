class Solution {
public:
    string crackSafe(int n, int k) {
        string res;
        for (int i = 0; i < n; ++i) {
            res += '0';
        }
        unordered_set<string> visited;
        visited.insert(res);
        dfs(res, visited, n, k);
        return res;
    }

    void dfs(string& password, unordered_set<string>& visited, int n, int k) {
        for (int i = 0; i < k; ++i) {
            string next = password.substr(password.size() - n + 1) + to_string(i);
            if (visited.find(next) == visited.end()) {
                visited.insert(next);
                password += to_string(i);
                dfs(password, visited, n, k);
                if (visited.size() == pow(k, n)) {
                    return;
                }
                password.pop_back();
                visited.erase(next);
            }
        }
    }
};