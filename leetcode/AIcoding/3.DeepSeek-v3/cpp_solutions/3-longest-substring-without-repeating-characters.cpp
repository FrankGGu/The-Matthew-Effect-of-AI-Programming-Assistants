class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        unordered_map<char, int> lastSeen;
        int start = 0;
        int maxLength = 0;

        for (int end = 0; end < s.size(); ++end) {
            char currentChar = s[end];
            if (lastSeen.find(currentChar) != lastSeen.end() && lastSeen[currentChar] >= start) {
                start = lastSeen[currentChar] + 1;
            }
            lastSeen[currentChar] = end;
            maxLength = max(maxLength, end - start + 1);
        }

        return maxLength;
    }
};