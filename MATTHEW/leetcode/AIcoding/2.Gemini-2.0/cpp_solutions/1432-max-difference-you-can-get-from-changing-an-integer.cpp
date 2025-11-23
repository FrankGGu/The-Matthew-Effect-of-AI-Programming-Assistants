#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxDiff(int num) {
        string s = to_string(num);
        int n = s.length();

        string a = s;
        for (int i = 0; i < n; ++i) {
            if (a[i] != '9') {
                char c = a[i];
                for (int j = 0; j < n; ++j) {
                    if (a[j] == c) {
                        a[j] = '9';
                    }
                }
                break;
            }
        }

        string b = s;
        if (b[0] != '1') {
            char c = b[0];
            for (int j = 0; j < n; ++j) {
                if (b[j] == c) {
                    b[j] = '1';
                }
            }
        } else {
            for (int i = 1; i < n; ++i) {
                if (b[i] != '0' && b[i] != '1') {
                    char c = b[i];
                    for (int j = 0; j < n; ++j) {
                        if (b[j] == c) {
                            b[j] = '0';
                        }
                    }
                    break;
                }
            }
        }

        return stoi(a) - stoi(b);
    }
};