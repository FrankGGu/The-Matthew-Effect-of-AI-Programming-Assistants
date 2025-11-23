#include <vector>
#include <string>
#include <numeric>

class Solution {
public:
    int countAnagrams(std::string s, std::string p) {
        if (p.length() > s.length()) {
            return 0;
        }

        std::vector<int> p_freq(26, 0);
        for (char c : p) {
            p_freq[c - 'a']++;
        }

        std::vector<int> s_freq(26, 0);
        int count = 0;
        int window_size = p.length();

        // Initialize the first window
        for (int i = 0; i < window_size; ++i) {
            s_freq[s[i] - 'a']++;
        }

        // Check the first window
        if (s_freq == p_freq) {
            count++;
        }

        // Slide the window
        for (int i = window_size; i < s.length(); ++i) {
            s_freq[s[i - window_size] - 'a']--; // Remove character leaving the window
            s_freq[s[i] - 'a']++;             // Add character entering the window

            if (s_freq == p_freq) {
                count++;
            }
        }

        return count;
    }
};