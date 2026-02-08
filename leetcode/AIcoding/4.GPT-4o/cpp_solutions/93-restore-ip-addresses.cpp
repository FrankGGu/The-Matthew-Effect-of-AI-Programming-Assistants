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

        for (int len = 1; len <= 3; ++len) {
            if (start + len > s.size()) break;
            string segment = s.substr(start, len);
            if ((segment[0] == '0' && segment.size() > 1) || stoi(segment) > 255) continue;
            path += (parts == 0 ? "" : ".") + segment;
            backtrack(s, start + len, parts + 1, path, result);
            path.erase(path.size() - segment.size() - (parts == 0 ? 0 : 1), segment.size() + (parts == 0 ? 0 : 1));
        }
    }
};