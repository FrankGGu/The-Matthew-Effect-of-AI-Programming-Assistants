class Solution {
public:
    int maxLengthBetweenEqualCharacters(string s) {
        unordered_map<char, int> firstOccurrence;
        int maxLen = -1;

        for (int i = 0; i < s.size(); ++i) {
            char c = s[i];
            if (firstOccurrence.find(c) != firstOccurrence.end()) {
                int len = i - firstOccurrence[c] - 1;
                if (len > maxLen) {
                    maxLen = len;
                }
            } else {
                firstOccurrence[c] = i;
            }
        }

        return maxLen;
    }
};