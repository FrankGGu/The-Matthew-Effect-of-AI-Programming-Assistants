#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int rearrangeCharacters(string s, string target) {
        unordered_map<char, int> s_count;
        unordered_map<char, int> target_count;

        for (char c : s) {
            s_count[c]++;
        }

        for (char c : target) {
            target_count[c]++;
        }

        int ans = INT_MAX;
        for (auto const& [key, val] : target_count) {
            if (s_count.find(key) == s_count.end()) {
                return 0;
            }
            ans = min(ans, s_count[key] / val);
        }

        return ans;
    }
};