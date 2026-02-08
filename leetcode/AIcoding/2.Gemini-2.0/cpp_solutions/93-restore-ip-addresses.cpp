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
    void restoreIpAddressesHelper(string s, int index, int count, string ip, vector<string>& result) {
        if (count == 4) {
            if (index == s.length()) {
                ip.pop_back(); // Remove the last '.'
                result.push_back(ip);
            }
            return;
        }

        for (int i = 1; i <= 3; i++) {
            if (index + i > s.length()) {
                break;
            }

            string segment = s.substr(index, i);
            if (segment.length() > 1 && segment[0] == '0') {
                continue;
            }

            int num = stoi(segment);
            if (num >= 0 && num <= 255) {
                restoreIpAddressesHelper(s, index + i, count + 1, ip + segment + ".", result);
            }
        }
    }
};