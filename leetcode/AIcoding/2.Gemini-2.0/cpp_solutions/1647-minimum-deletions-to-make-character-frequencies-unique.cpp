#include <vector>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    int minDeletions(string s) {
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        sort(freq.begin(), freq.end(), greater<int>());

        int deletions = 0;
        unordered_set<int> seen;

        for (int i = 0; i < 26; ++i) {
            while (freq[i] > 0 && seen.count(freq[i])) {
                freq[i]--;
                deletions++;
            }
            seen.insert(freq[i]);
        }

        return deletions;
    }
};