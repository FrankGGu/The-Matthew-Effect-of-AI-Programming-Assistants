#include <iostream>
#include <vector>
#include <unordered_map>

class Solution {
public:
    int lengthOfLongestSubstring(std::string s) {
        std::unordered_map<char, int> charIndexMap;
        int maxLength = 0;
        int left = 0;

        for (int right = 0; right < s.length(); ++right) {
            char currentChar = s[right];
            if (charIndexMap.find(currentChar) != charIndexMap.end() && charIndexMap[currentChar] >= left) {
                left = charIndexMap[currentChar] + 1;
            }
            charIndexMap[currentChar] = right;
            maxLength = std::max(maxLength, right - left + 1);
        }

        return maxLength;
    }
};