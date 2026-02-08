#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int longestDecomposition(string s) {
        int n = s.length();
        vector<int> lps(n, 0);
        for (int i = 1; i < n; i++) {
            int j = lps[i - 1];
            while (j > 0 && s[i] != s[j]) {
                j = lps[j - 1];
            }
            if (s[i] == s[j]) {
                j++;
            }
            lps[i] = j;
        }

        int result = 0;
        int start = 0;
        int end = n - 1;
        int left = 0;
        int right = n - 1;

        while (left <= right) {
            int len = 0;
            while (left + len <= right && s[left + len] == s[right - len]) {
                len++;
            }
            if (len > 0) {
                result++;
                left += len;
                right -= len;
            } else {
                break;
            }
        }

        return result;
    }
};