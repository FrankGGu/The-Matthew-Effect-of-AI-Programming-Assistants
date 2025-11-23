class Solution {
public:
    int maximumLengthSubstring(string s) {
        int n = s.size();
        int maxLength = 0;
        unordered_map<char, int> charCount;

        for (int left = 0; left < n; left++) {
            charCount.clear();
            for (int right = left; right < n; right++) {
                charCount[s[right]]++;
                if (charCount.size() > 2) {
                    break;
                }
                if (charCount.size() == 2) {
                    maxLength = max(maxLength, right - left + 1);
                }
            }
        }

        return maxLength;
    }
};