#include <vector>
#include <string>
#include <unordered_map>
#include <climits>

using namespace std;

class Solution {
public:
    string minWindow(string s, string t) {
        unordered_map<char, int> target;
        for (char c : t) {
            target[c]++;
        }

        int left = 0, right = 0;
        int required = target.size();
        int formed = 0;
        unordered_map<char, int> window;
        int min_len = INT_MAX;
        string result = "";

        while (right < s.size()) {
            char c = s[right];
            window[c]++;

            if (target.count(c) && window[c] == target[c]) {
                formed++;
            }

            while (left <= right && formed == required) {
                if (right - left + 1 < min_len) {
                    min_len = right - left + 1;
                    result = s.substr(left, min_len);
                }

                char left_char = s[left];
                window[left_char]--;
                if (target.count(left_char) && window[left_char] < target[left_char]) {
                    formed--;
                }
                left++;
            }

            right++;
        }

        return result;
    }
};