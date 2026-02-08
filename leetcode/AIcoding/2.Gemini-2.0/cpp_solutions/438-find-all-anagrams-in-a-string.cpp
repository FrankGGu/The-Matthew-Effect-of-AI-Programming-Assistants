#include <vector>
#include <string>

using namespace std;

class Solution {
public:
    vector<int> findAnagrams(string s, string p) {
        vector<int> result;
        int n = s.length();
        int m = p.length();

        if (m > n) {
            return result;
        }

        vector<int> p_freq(26, 0);
        vector<int> s_freq(26, 0);

        for (char c : p) {
            p_freq[c - 'a']++;
        }

        for (int i = 0; i < m; i++) {
            s_freq[s[i] - 'a']++;
        }

        for (int i = 0; i <= n - m; i++) {
            if (s_freq == p_freq) {
                result.push_back(i);
            }

            if (i < n - m) {
                s_freq[s[i] - 'a']--;
                s_freq[s[i + m] - 'a']++;
            }
        }

        return result;
    }
};