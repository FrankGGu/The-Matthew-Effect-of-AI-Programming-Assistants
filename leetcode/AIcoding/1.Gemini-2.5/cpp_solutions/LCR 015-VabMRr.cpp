#include <vector>
#include <string>

class Solution {
public:
    std::vector<int> findAnagrams(std::string s, std::string p) {
        std::vector<int> result;
        if (s.length() < p.length()) {
            return result;
        }

        std::vector<int> p_freq(26, 0);
        std::vector<int> s_freq(26, 0);

        for (char c : p) {
            p_freq[c - 'a']++;
        }

        int p_len = p.length();
        int s_len = s.length();

        for (int i = 0; i < p_len; ++i) {
            s_freq[s[i] - 'a']++;
        }

        if (s_freq == p_freq) {
            result.push_back(0);
        }

        for (int i = p_len; i < s_len; ++i) {
            s_freq[s[i - p_len] - 'a']--;
            s_freq[s[i] - 'a']++;

            if (s_freq == p_freq) {
                result.push_back(i - p_len + 1);
            }
        }

        return result;
    }
};