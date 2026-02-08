class Solution {
public:
    vector<string> restoreIpAddresses(string s) {
        vector<string> result;
        string path;
        backtrack(s, 0, 0, path, result);
        return result;
    }

    void backtrack(string& s, int start, int parts, string& path, vector<string>& result) {
        if (parts == 4 && start == s.size()) {
            result.push_back(path);
            return;
        }
        if (parts >= 4) return;

        for (int len = 1; len <= 3; len++) {
            if (start + len > s.size()) break;
            string segment = s.substr(start, len);
            if ((segment.size() > 1 && segment[0] == '0') || stoi(segment) > 255) continue;
            string temp = path;
            if (parts > 0) temp += ".";
            temp += segment;
            backtrack(s, start + len, parts + 1, temp, result);
        }
    }
};