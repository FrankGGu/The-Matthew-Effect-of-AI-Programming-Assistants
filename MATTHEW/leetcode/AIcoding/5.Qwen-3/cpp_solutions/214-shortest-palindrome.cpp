#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    string shortestPalindrome(string s) {
        int n = s.size();
        string rev = s;
        reverse(rev.begin(), rev.end());
        string combined = s + '#' + rev;
        vector<int> lps(combined.size(), 0);

        for (int i = 1; i < combined.size(); ++i) {
            int j = lps[i - 1];
            while (j > 0 && combined[i] != combined[j]) {
                j = lps[j - 1];
            }
            if (combined[i] == combined[j]) {
                j++;
            }
            lps[i] = j;
        }

        return rev.substr(0, n - lps.back()) + s;
    }
};