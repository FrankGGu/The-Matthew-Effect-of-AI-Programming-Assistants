#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestValidSubstring(string s) {
        int result = 0;
        int n = s.length();
        unordered_map<char, int> last_pos;
        int left = 0;
        for (int right = 0; right < n; ++right) {
            if (last_pos.find(s[right]) != last_pos.end() && last_pos[s[right]] >= left) {
                left = last_pos[s[right]] + 1;
            }
            last_pos[s[right]] = right;
            result = max(result, right - left + 1);
        }
        return result;
    }
};