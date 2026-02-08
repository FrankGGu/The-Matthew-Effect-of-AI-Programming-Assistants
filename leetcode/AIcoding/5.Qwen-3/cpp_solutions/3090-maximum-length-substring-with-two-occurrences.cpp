#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumLengthSubstring(string s) {
        unordered_map<char, int> count;
        int left = 0, maxLen = 0;
        for (int right = 0; right < s.size(); ++right) {
            count[s[right]]++;
            while (count[s[right]] > 2) {
                count[s[left]]--;
                left++;
            }
            maxLen = max(maxLen, right - left + 1);
        }
        return maxLen;
    }
};