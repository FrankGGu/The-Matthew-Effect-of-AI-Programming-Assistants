#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int numberOfUniqueChars(const string& s) {
        int n = s.length();
        vector<int> prev(n, -1);
        vector<int> next(n, n);

        vector<int> lastOccurrence(26, -1);
        for (int i = 0; i < n; ++i) {
            if (lastOccurrence[s[i] - 'a'] != -1) {
                prev[i] = lastOccurrence[s[i] - 'a'];
            }
            lastOccurrence[s[i] - 'a'] = i;
        }

        fill(lastOccurrence.begin(), lastOccurrence.end(), n);
        for (int i = n - 1; i >= 0; --i) {
            if (lastOccurrence[s[i] - 'a'] != n) {
                next[i] = lastOccurrence[s[i] - 'a'];
            }
            lastOccurrence[s[i] - 'a'] = i;
        }

        int result = 0;
        for (int i = 0; i < n; ++i) {
            result += (i - prev[i]) * (next[i] - i);
        }
        return result;
    }
};