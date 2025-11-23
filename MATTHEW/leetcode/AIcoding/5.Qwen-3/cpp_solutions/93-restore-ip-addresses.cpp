#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<string> restoreIpAddresses(string s) {
        vector<string> result;
        int n = s.size();
        for (int a = 1; a <= 3; ++a) {
            for (int b = 1; b <= 3; ++b) {
                for (int c = 1; c <= 3; ++c) {
                    for (int d = 1; d <= 3; ++d) {
                        if (a + b + c + d != n) continue;
                        string part1 = s.substr(0, a);
                        string part2 = s.substr(a, b);
                        string part3 = s.substr(a + b, c);
                        string part4 = s.substr(a + b + c, d);
                        if (isValid(part1) && isValid(part2) && isValid(part3) && isValid(part4)) {
                            result.push_back(part1 + "." + part2 + "." + part3 + "." + part4);
                        }
                    }
                }
            }
        }
        return result;
    }

private:
    bool isValid(string s) {
        if (s.empty() || s.size() > 3) return false;
        if (s.size() > 1 && s[0] == '0') return false;
        int num = stoi(s);
        return num >= 0 && num <= 255;
    }
};