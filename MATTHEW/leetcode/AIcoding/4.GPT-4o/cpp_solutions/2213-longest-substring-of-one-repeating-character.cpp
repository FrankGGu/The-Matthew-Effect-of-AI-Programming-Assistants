class Solution {
public:
    int characterReplacement(string s, int k) {
        unordered_map<char, int> count;
        int maxCount = 0, left = 0, maxLength = 0;

        for (int right = 0; right < s.size(); right++) {
            count[s[right]]++;
            maxCount = max(maxCount, count[s[right]]);

            while (right - left + 1 - maxCount > k) {
                count[s[left]]--;
                left++;
            }

            maxLength = max(maxLength, right - left + 1);
        }

        return maxLength;
    }
};