#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    int minChanges(string s, int k) {
        int n = s.length();
        vector<int> count(26, 0);
        for (int i = 0; i < k; ++i) {
            count[s[i] - 'a']++;
        }
        int maxFreq = *max_element(count.begin(), count.end());
        int changes = k - maxFreq;
        for (int i = k; i < n; ++i) {
            count[s[i - k] - 'a']--;
            count[s[i] - 'a']++;
            maxFreq = *max_element(count.begin(), count.end());
            changes += (k - maxFreq);
        }
        return changes;
    }
};