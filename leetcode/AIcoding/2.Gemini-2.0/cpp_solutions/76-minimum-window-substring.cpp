#include <string>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    string minWindow(string s, string t) {
        if (s.empty() || t.empty()) return "";

        unordered_map<char, int> t_freq;
        for (char c : t) {
            t_freq[c]++;
        }

        int required = t_freq.size();
        int formed = 0;

        unordered_map<char, int> window_freq;
        int left = 0, right = 0;

        int min_len = INT_MAX;
        int start = 0;

        while (right < s.length()) {
            char c = s[right];
            window_freq[c]++;

            if (t_freq.count(c) && window_freq[c] == t_freq[c]) {
                formed++;
            }

            while (left <= right && formed == required) {
                if (right - left + 1 < min_len) {
                    min_len = right - left + 1;
                    start = left;
                }

                char left_char = s[left];
                window_freq[left_char]--;

                if (t_freq.count(left_char) && window_freq[left_char] < t_freq[left_char]) {
                    formed--;
                }

                left++;
            }

            right++;
        }

        return min_len == INT_MAX ? "" : s.substr(start, min_len);
    }
};