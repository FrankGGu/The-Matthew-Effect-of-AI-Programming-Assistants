#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minimumSplits(string s) {
        int n = s.length();
        int count = 1;
        vector<int> lastOccurrence(26, -1);

        for (int i = 0; i < n; ++i) {
            int maxLast = -1;
            for (int j = 0; j < 26; ++j) {
                if (lastOccurrence[j] != -1 && lastOccurrence[j] < i) {
                    lastOccurrence[j] = -1;
                }
            }

            for (int j = 0; j < i; ++j) {
                if (s[j] == s[i]) {
                    count++;
                    lastOccurrence.assign(26, -1);
                    break;
                }
            }

            lastOccurrence[s[i] - 'a'] = i;
        }

        return count;
    }
};