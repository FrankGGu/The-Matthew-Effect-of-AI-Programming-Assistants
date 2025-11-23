#include <vector>
#include <string>

class Solution {
public:
    std::vector<int> findAnagrams(std::string s, std::string p) {
        std::vector<int> result;
        int s_len = s.length();
        int p_len = p.length();

        if (s_len < p_len) {
            return result;
        }

        std::vector<int> p_freq(26, 0);
        std::vector<int> s_window_freq(26, 0);

        for (int i = 0; i < p_len; ++i) {
            p_freq[p[i] - 'a']++;
            s_window_freq[s[i] - 'a']++;
        }

        if (p_freq == s_window_freq) {
            result.push_back(0);
        }

        for (int i = p_len; i < s_len; ++i) {
            s_window_freq[s[i] - 'a']++;
            s_window_freq[s[i - p_len] - 'a']--;

            if (p_freq == s_window_freq) {
                result.push_back(i - p_len + 1);
            }
        }

        return result;
    }
};