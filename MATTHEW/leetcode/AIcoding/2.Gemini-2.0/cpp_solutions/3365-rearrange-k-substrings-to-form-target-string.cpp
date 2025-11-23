#include <string>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    bool rearrangeKSubstrings(string s, string target, int k) {
        if (target.length() > s.length()) {
            return false;
        }

        map<char, int> s_freq;
        map<char, int> target_freq;

        for (char c : s) {
            s_freq[c]++;
        }

        for (char c : target) {
            target_freq[c]++;
        }

        for (auto const& [key, val] : target_freq) {
            if (s_freq.find(key) == s_freq.end() || s_freq[key] < val) {
                return false;
            }
        }

        if (k > target.length()) {
            return true;
        }

        return true;

    }
};