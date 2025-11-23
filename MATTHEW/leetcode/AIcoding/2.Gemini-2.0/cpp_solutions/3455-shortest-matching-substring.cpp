#include <string>
#include <vector>
#include <algorithm>

using namespace std;

string minWindow(string s, string t) {
    if (s.empty() || t.empty()) return "";

    vector<int> freq(256, 0);
    for (char c : t) {
        freq[c]++;
    }

    int left = 0, right = 0, matched = 0, minLen = INT_MAX, start = 0;

    while (right < s.length()) {
        if (freq[s[right]] > 0) {
            matched++;
        }
        freq[s[right]]--;

        while (matched == t.length()) {
            if (right - left + 1 < minLen) {
                minLen = right - left + 1;
                start = left;
            }

            freq[s[left]]++;
            if (freq[s[left]] > 0) {
                matched--;
            }
            left++;
        }
        right++;
    }

    return minLen == INT_MAX ? "" : s.substr(start, minLen);
}