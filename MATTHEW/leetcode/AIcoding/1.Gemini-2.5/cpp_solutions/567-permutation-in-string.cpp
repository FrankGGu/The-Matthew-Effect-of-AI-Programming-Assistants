#include <string>
#include <vector>
#include <numeric>

class Solution {
public:
    bool checkInclusion(std::string s1, std::string s2) {
        if (s1.length() > s2.length()) {
            return false;
        }

        std::vector<int> s1_freq(26, 0);
        std::vector<int> window_freq(26, 0);

        for (char c : s1) {
            s1_freq[c - 'a']++;
        }

        for (int i = 0; i < s1.length(); ++i) {
            window_freq[s2[i] - 'a']++;
        }

        if (s1_freq == window_freq) {
            return true;
        }

        for (int i = s1.length(); i < s2.length(); ++i) {
            window_freq[s2[i - s1.length()] - 'a']--;
            window_freq[s2[i] - 'a']++;
            if (s1_freq == window_freq) {
                return true;
            }
        }

        return false;
    }
};