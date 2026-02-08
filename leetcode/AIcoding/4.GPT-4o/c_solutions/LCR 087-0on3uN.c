class Solution {
public:
    vector<string> restoreIpAddresses(string s) {
        vector<string> result;
        string current;
        backtrack(s, 0, 0, current, result);
        return result;
    }

    void backtrack(string& s, int start, int part, string& current, vector<string>& result) {
        if (part == 4) {
            if (start == s.size()) {
                result.push_back(current);
            }
            return;
        }

        for (int len = 1; len <= 3; ++len) {
            if (start + len > s.size()) break;
            string segment = s.substr(start, len);
            if ((segment[0] == '0' && len > 1) || (len == 3 && stoi(segment) > 255)) {
                continue;
            }
            string temp = current;
            if (!temp.empty()) temp += '.';
            temp += segment;
            backtrack(s, start + len, part + 1, temp, result);
        }
    }
};