class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        unordered_map<char, int> charMap;
        int maxLength = 0, left = 0;

        for (int right = 0; right < s.size(); ++right) {
            if (charMap.find(s[right]) != charMap.end()) {
                left = max(left, charMap[s[right]] + 1);
            }
            charMap[s[right]] = right;
            maxLength = max(maxLength, right - left + 1);
        }

        return maxLength;
    }
};