class Solution {
public:
    vector<string> restoreIpAddresses(string s) {
        vector<string> result;
        string path;
        backtrack(s, 0, 0, path, result);
        return result;
    }

private:
    void backtrack(const string& s, int start, int part, string path, vector<string>& result) {
        if (part == 4 && start == s.size()) {
            path.pop_back();
            result.push_back(path);
            return;
        }
        if (part == 4 || start == s.size()) {
            return;
        }
        for (int len = 1; len <= 3 && start + len <= s.size(); ++len) {
            string numStr = s.substr(start, len);
            if (numStr.size() > 1 && numStr[0] == '0') {
                break;
            }
            int num = stoi(numStr);
            if (num <= 255) {
                backtrack(s, start + len, part + 1, path + numStr + ".", result);
            }
        }
    }
};