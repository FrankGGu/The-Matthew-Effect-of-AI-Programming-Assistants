#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> restoreIpAddresses(string s) {
        vector<string> result;
        string ip;
        restoreIpAddressesHelper(s, 0, 0, ip, result);
        return result;
    }

private:
    void restoreIpAddressesHelper(string s, int index, int segment, string ip, vector<string>& result) {
        if (segment == 4) {
            if (index == s.length()) {
                ip.pop_back();
                result.push_back(ip);
            }
            return;
        }

        for (int i = 1; i <= 3 && index + i <= s.length(); ++i) {
            string sub = s.substr(index, i);
            if (sub.length() > 1 && sub[0] == '0') continue;
            int val = stoi(sub);
            if (val >= 0 && val <= 255) {
                restoreIpAddressesHelper(s, index + i, segment + 1, ip + sub + ".", result);
            }
        }
    }
};