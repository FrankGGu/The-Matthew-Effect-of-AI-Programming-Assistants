#include <string>

using namespace std;

class Solution {
public:
    long long maximumSubsequenceCount(string text, string pattern) {
        long long ans = 0;
        string t1 = pattern[0] + text;
        string t2 = text + pattern[1];

        long long count1 = 0;
        long long res1 = 0;
        for (char c : t1) {
            if (c == pattern[1]) {
                res1 += count1;
            }
            if (c == pattern[0]) {
                count1++;
            }
        }

        long long count2 = 0;
        long long res2 = 0;
        for (char c : t2) {
            if (c == pattern[1]) {
                res2 += count2;
            }
            if (c == pattern[0]) {
                count2++;
            }
        }

        ans = max(res1, res2);
        return ans;
    }
};