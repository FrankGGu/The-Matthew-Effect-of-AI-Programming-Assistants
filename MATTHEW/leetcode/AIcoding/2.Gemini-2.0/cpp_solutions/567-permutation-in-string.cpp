#include <string>
#include <vector>

using namespace std;

class Solution {
public:
    bool checkInclusion(string s1, string s2) {
        if (s1.length() > s2.length()) {
            return false;
        }

        vector<int> s1_freq(26, 0);
        vector<int> s2_freq(26, 0);

        for (char c : s1) {
            s1_freq[c - 'a']++;
        }

        for (int i = 0; i < s1.length(); i++) {
            s2_freq[s2[i] - 'a']++;
        }

        for (int i = 0; i <= s2.length() - s1.length(); i++) {
            if (s1_freq == s2_freq) {
                return true;
            }

            if (i < s2.length() - s1.length()) {
                s2_freq[s2[i] - 'a']--;
                s2_freq[s2[i + s1.length()] - 'a']++;
            }
        }

        return false;
    }
};