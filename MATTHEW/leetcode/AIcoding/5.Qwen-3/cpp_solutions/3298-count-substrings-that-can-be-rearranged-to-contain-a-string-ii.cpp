#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int countCompleteSubstrings(string s) {
        vector<int> counts(26, 0);
        int result = 0;
        int n = s.length();

        for (int i = 0; i < n; ) {
            int j = i;
            while (j < n && s[j] == s[i]) {
                j++;
            }
            int len = j - i;
            int k = 0;
            while (k <= len) {
                if (k > 0) {
                    counts[s[i] - 'a']--;
                }
                int total = 0;
                for (int m = 0; m < 26; m++) {
                    total += counts[m];
                }
                if (total == k) {
                    result++;
                }
                if (k < len) {
                    counts[s[i] - 'a']++;
                }
                k++;
            }
            i = j;
        }
        return result;
    }
};