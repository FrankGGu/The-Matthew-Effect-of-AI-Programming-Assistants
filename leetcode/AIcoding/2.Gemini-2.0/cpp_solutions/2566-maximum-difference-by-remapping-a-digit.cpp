#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDiff(int num) {
        string s = to_string(num);
        int n = s.size();

        int max_num = num;
        int min_num = num;

        for (int i = 0; i < n; ++i) {
            string t = s;
            char digit = s[i];

            if (digit != '9') {
                char replace_with = '9';
                for (int j = 0; j < n; ++j) {
                    if (t[j] == digit) {
                        t[j] = replace_with;
                    }
                }
                max_num = max(max_num, stoi(t));
            }

            t = s;
            digit = s[i];

            if (i == 0) {
                if (digit != '1') {
                    char replace_with = '1';
                    for (int j = 0; j < n; ++j) {
                        if (t[j] == digit) {
                            t[j] = replace_with;
                        }
                    }
                    min_num = min(min_num, stoi(t));
                }
            } else {
                if (digit != '0') {
                    char replace_with = '0';
                    for (int j = 0; j < n; ++j) {
                        if (t[j] == digit) {
                            t[j] = replace_with;
                        }
                    }
                    min_num = min(min_num, stoi(t));
                }
            }
        }

        return max_num - min_num;
    }
};