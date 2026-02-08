#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxRepOptI(string text) {
        int n = text.size();
        vector<int> count(26, 0);
        for (char c : text) {
            count[c - 'a']++;
        }

        int maxLen = 0;
        int i = 0;
        while (i < n) {
            char c = text[i];
            int j = i;
            while (j < n && text[j] == c) {
                j++;
            }
            int len = j - i;
            if (len > 1) {
                maxLen = max(maxLen, len);
            }
            if (j < n) {
                int k = j + 1;
                while (k < n && text[k] == c) {
                    k++;
                }
                if (count[c - 'a'] > len + (k - j)) {
                    maxLen = max(maxLen, len + (k - j));
                } else {
                    maxLen = max(maxLen, len + (k - j) - 1);
                }
            }
            i = j;
        }

        return maxLen;
    }
};