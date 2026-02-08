#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> restoreIpAddresses(string s) {
        vector<string> result;
        string ip;
        dfs(s, 0, 0, ip, result);
        return result;
    }

private:
    void dfs(string s, int start, int segment, string ip, vector<string>& result) {
        if (segment == 4) {
            if (start == s.length()) {
                ip.pop_back();
                result.push_back(ip);
            }
            return;
        }

        for (int len = 1; len <= 3; ++len) {
            if (start + len > s.length()) {
                break;
            }

            string sub = s.substr(start, len);
            if (sub.length() > 1 && sub[0] == '0') {
                continue;
            }

            int val = stoi(sub);
            if (val > 255) {
                break;
            }

            dfs(s, start + len, segment + 1, ip + sub + ".", result);
        }
    }
};