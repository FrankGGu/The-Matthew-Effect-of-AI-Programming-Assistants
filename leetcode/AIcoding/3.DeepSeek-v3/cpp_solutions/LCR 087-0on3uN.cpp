#include <vector>
#include <string>
#include <cctype>
using namespace std;

class Solution {
public:
    vector<string> restoreIpAddresses(string s) {
        vector<string> result;
        vector<string> current;
        dfs(s, 0, current, result);
        return result;
    }

private:
    void dfs(string& s, int start, vector<string>& current, vector<string>& result) {
        if (current.size() == 4) {
            if (start == s.size()) {
                string ip = current[0] + '.' + current[1] + '.' + current[2] + '.' + current[3];
                result.push_back(ip);
            }
            return;
        }

        int remaining = s.size() - start;
        int segments = 4 - current.size();
        if (remaining < segments || remaining > segments * 3) {
            return;
        }

        for (int len = 1; len <= 3 && start + len <= s.size(); ++len) {
            string seg = s.substr(start, len);
            if (isValid(seg)) {
                current.push_back(seg);
                dfs(s, start + len, current, result);
                current.pop_back();
            }
        }
    }

    bool isValid(string seg) {
        if (seg.empty() || seg.size() > 3) {
            return false;
        }
        if (seg[0] == '0' && seg.size() > 1) {
            return false;
        }
        int num = 0;
        for (char c : seg) {
            if (!isdigit(c)) return false;
            num = num * 10 + (c - '0');
        }
        return num <= 255;
    }
};