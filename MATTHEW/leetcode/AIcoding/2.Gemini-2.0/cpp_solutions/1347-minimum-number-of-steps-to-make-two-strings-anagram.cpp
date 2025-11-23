#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    int minSteps(string s, string t) {
        vector<int> freq(26, 0);
        for (char c : s) {
            freq[c - 'a']++;
        }
        for (char c : t) {
            freq[c - 'a']--;
        }
        int steps = 0;
        for (int i = 0; i < 26; i++) {
            if (freq[i] > 0) {
                steps += freq[i];
            }
        }
        return steps;
    }
};