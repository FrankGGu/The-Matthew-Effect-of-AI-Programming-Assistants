class Solution {
public:
    int longestSubstring(string s, int k) {
        int maxLength = 0;
        int n = s.size();

        for (int uniqueChars = 1; uniqueChars <= 26; ++uniqueChars) {
            unordered_map<char, int> count;
            int left = 0, right = 0, countAtLeastK = 0;

            while (right < n) {
                if (count[s[right]]++ == 0) uniqueChars--;
                if (count[s[right]] == k) countAtLeastK++;
                while (uniqueChars < 0) {
                    if (count[s[left]]-- == k) countAtLeastK--;
                    if (count[s[left]] == 0) uniqueChars++;
                    left++;
                }
                if (countAtLeastK == uniqueChars) {
                    maxLength = max(maxLength, right - left + 1);
                }
                right++;
            }
        }

        return maxLength;
    }
};