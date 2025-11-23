#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int sumScores(string s) {
        int n = s.size();
        vector<int> lps(n, 0);
        for (int i = 1; i < n; ++i) {
            int j = lps[i - 1];
            while (j > 0 && s[i] != s[j]) {
                j = lps[j - 1];
            }
            if (s[i] == s[j]) {
                ++j;
            }
            lps[i] = j;
        }
        int total = 0;
        for (int i = 0; i < n; ++i) {
            total += lps[i];
        }
        return total;
    }
};