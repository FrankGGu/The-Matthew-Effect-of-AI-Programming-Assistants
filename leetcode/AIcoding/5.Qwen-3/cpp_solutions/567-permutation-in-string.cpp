#include <iostream>
#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    bool checkInclusion(string s1, string s2) {
        if (s1.length() > s2.length()) return false;

        vector<int> count(26, 0);
        vector<int> window(26, 0);

        for (char c : s1) {
            count[c - 'a']++;
        }

        int left = 0;
        int right = 0;
        int len = s1.length();

        while (right < s2.length()) {
            window[s2[right] - 'a']++;

            if (right - left + 1 == len) {
                if (window == count) return true;

                window[s2[left] - 'a']--;
                left++;
            }

            right++;
        }

        return false;
    }
};