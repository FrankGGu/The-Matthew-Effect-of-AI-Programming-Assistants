#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minFlips(string s) {
        int n = s.length();
        string s1 = "", s2 = "";
        for (int i = 0; i < n; ++i) {
            s1 += (i % 2 == 0) ? '0' : '1';
            s2 += (i % 2 == 0) ? '1' : '0';
        }

        int flips1 = 0, flips2 = 0;
        for (int i = 0; i < n; ++i) {
            if (s[i] != s1[i]) flips1++;
            if (s[i] != s2[i]) flips2++;
        }

        int ans = min(flips1, flips2);

        for (int i = 0; i < n; ++i) {
            if (s[i] != s1[i]) flips1--;
            else flips1++;
            if (s[i] != s2[i]) flips2--;
            else flips2++;

            s1 += s1[i];
            s2 += s2[i];

            s1.erase(0, 1);
            s2.erase(0, 1);

            ans = min(ans, min(flips1, flips2));
        }

        return ans;
    }
};