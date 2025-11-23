#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        vector<int> result;
        if (s.length() < p.length()) {
            return result;
        }

        vector<int> p_freq(26, 0);
        vector<int> s_freq(26, 0);

        for (char c : p) {
            p_freq[c - 'a']++;
        }

        for (int i = 0; i < p.length(); ++i) {
            s_freq[s[i] - 'a']++;
        }

        for (int i = 0; i <= s.length() - p.length(); ++i) {
            if (s_freq == p_freq) {
                result.push_back(i);
            }

            if (i < s.length() - p.length()) {
                s_freq[s[i] - 'a']--;
                s_freq[s[i + p.length()] - 'a']++;
            }
        }

        return result;
    }
};