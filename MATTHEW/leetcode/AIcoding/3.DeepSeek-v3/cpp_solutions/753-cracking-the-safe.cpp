class Solution {
public:
    string crackSafe(int n, int k) {
        string res(n, '0');
        unordered_set<string> visited;
        visited.insert(res);
        int total = pow(k, n);
        dfs(res, visited, total, n, k);
        return res;
    }

    bool dfs(string& res, unordered_set<string>& visited, int total, int n, int k) {
        if (visited.size() == total) return true;
        string prev = res.substr(res.size() - n + 1);
        for (int i = 0; i < k; ++i) {
            char c = '0' + i;
            string next = prev + c;
            if (visited.find(next) == visited.end()) {
                visited.insert(next);
                res += c;
                if (dfs(res, visited, total, n, k)) return true;
                res.pop_back();
                visited.erase(next);
            }
        }
        return false;
    }
};