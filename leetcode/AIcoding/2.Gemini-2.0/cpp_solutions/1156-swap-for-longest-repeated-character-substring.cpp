#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxRepOpt1(string text) {
        int n = text.size();
        vector<int> count(26, 0);
        for (char c : text) {
            count[c - 'a']++;
        }

        int ans = 0;
        for (int i = 0; i < n; ++i) {
            int j = i;
            while (j < n && text[j] == text[i]) {
                j++;
            }
            int len = j - i;

            if (len < count[text[i] - 'a']) {
                ans = max(ans, len + 1);
            } else {
                ans = max(ans, len);
            }

            if (j < n) {
                int k = j;
                while (k < n && text[k] == text[i]) {
                    k++;
                }
                int len2 = k - j;
                if (len + len2 < count[text[i] - 'a']) {
                    ans = max(ans, len + len2 + 1);
                } else {
                    ans = max(ans, len + len2);
                }
            }

            i = j - 1;
        }

        return ans;
    }
};