#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minSteps(string s, string t) {
        vector<int> s_freq(26, 0);
        vector<int> t_freq(26, 0);

        for (char c : s) {
            s_freq[c - 'a']++;
        }

        for (char c : t) {
            t_freq[c - 'a']++;
        }

        int steps = 0;
        for (int i = 0; i < 26; ++i) {
            steps += abs(s_freq[i] - t_freq[i]);
        }

        return steps;
    }
};