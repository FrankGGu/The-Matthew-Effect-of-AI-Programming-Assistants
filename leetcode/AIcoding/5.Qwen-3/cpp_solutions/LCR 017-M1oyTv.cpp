#include <iostream>
#include <vector>
#include <string>
#include <unordered_map>

using namespace std;

class Solution {
public:
    string minWindow(string s, string t) {
        if (s.empty() || t.empty()) return "";

        unordered_map<char, int> need;
        unordered_map<char, int> window;

        for (char c : t) {
            need[c]++;
        }

        int left = 0, right = 0;
        int valid = 0;
        int len = INT_MAX;
        int start = 0, end = 0;

        while (right < s.size()) {
            char c = s[right];
            right++;

            if (need.count(c)) {
                window[c]++;
                if (window[c] == need[c]) {
                    valid++;
                }
            }

            while (valid == need.size()) {
                if (right - left < len) {
                    len = right - left;
                    start = left;
                    end = right;
                }

                char d = s[left];
                left++;

                if (need.count(d)) {
                    if (window[d] == need[d]) {
                        valid--;
                    }
                    window[d]--;
                }
            }
        }

        return len == INT_MAX ? "" : s.substr(start, end - start);
    }
};