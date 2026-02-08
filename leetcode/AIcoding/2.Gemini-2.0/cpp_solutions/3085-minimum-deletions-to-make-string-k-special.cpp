#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minDeletions(string s, int k) {
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }

        sort(freq.begin(), freq.end(), greater<int>());

        int deletions = 0;
        int prevFreq = s.length();
        for (int i = 0; i < 26; ++i) {
            if (freq[i] == 0) break;
            if (freq[i] > prevFreq) {
                deletions += (freq[i] - prevFreq);
                freq[i] = prevFreq;
            }
            prevFreq = max(0, freq[i] - 1);
        }

        return deletions;
    }
};