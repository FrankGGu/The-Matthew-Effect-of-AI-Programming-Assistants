#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestSubstring(string s, int k) {
        int n = s.length();
        if (n == 0 || n < k) return 0;
        unordered_map<char, int> count;
        for (char c : s) {
            count[c]++;
        }
        for (int i = 0; i < n; i++) {
            if (count[s[i]] < k) {
                int left = longestSubstring(s.substr(0, i), k);
                int right = longestSubstring(s.substr(i + 1), k);
                return max(left, right);
            }
        }
        return n;
    }
};