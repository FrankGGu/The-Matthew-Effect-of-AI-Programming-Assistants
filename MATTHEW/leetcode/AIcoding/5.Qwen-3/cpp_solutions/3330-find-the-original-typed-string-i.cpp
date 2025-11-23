#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string decode(const string& s) {
        string result;
        int n = s.length();
        for (int i = 0; i < n; ) {
            if (s[i] >= '0' && s[i] <= '9') {
                int num = 0;
                while (i < n && s[i] >= '0' && s[i] <= '9') {
                    num = num * 10 + (s[i] - '0');
                    ++i;
                }
                int count = 0;
                while (i < n && s[i] >= 'a' && s[i] <= 'z') {
                    result += s[i];
                    ++i;
                    ++count;
                }
                if (count > 0) {
                    for (int j = 1; j < num; ++j) {
                        for (int k = 0; k < count; ++k) {
                            result += result[result.length() - count + k];
                        }
                    }
                }
            } else {
                result += s[i];
                ++i;
            }
        }
        return result;
    }

    string originalString(const vector<string>& encoded) {
        string result;
        for (const string& s : encoded) {
            result += decode(s);
        }
        return result;
    }
};