class Solution {
public:
    string getHappyString(int n, int k) {
        vector<string> res;
        string path;
        backtrack(n, path, res);
        if (k > res.size()) return "";
        return res[k-1];
    }

    void backtrack(int n, string& path, vector<string>& res) {
        if (path.size() == n) {
            res.push_back(path);
            return;
        }
        for (char c : {'a', 'b', 'c'}) {
            if (!path.empty() && path.back() == c) continue;
            path.push_back(c);
            backtrack(n, path, res);
            path.pop_back();
        }
    }
};