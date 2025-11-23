#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    string smallestBeautifulString(string s, int k) {
        int n = s.size();
        vector<char> result(n);
        bool found = false;

        for (int i = n - 1; i >= 0; --i) {
            if (s[i] < 'a' + k - 1) {
                result[i] = s[i] + 1;
                for (int j = i + 1; j < n; ++j) {
                    result[j] = 'a';
                }
                found = true;
                break;
            }
        }

        if (!found) {
            return "";
        }

        for (int i = 0; i < n; ++i) {
            if (result[i] == 0) {
                result[i] = 'a';
            }
            while (i > 0 && result[i] == result[i - 1]) {
                result[i]++;
            }
            if (result[i] - 'a' >= k) {
                return "";
            }
        }

        for (int i = 1; i < n; ++i) {
            if (result[i] == result[i - 1]) {
                return "";
            }
        }

        return string(result.begin(), result.end());
    }
};