class Solution {
public:
    int countKSubstrings(string s, int k) {
        int n = s.size(), result = 0;
        unordered_map<char, int> charCount;

        for (int start = 0; start < n; ++start) {
            charCount.clear();
            int distinctCount = 0;

            for (int end = start; end < n; ++end) {
                if (++charCount[s[end]] == 1) {
                    distinctCount++;
                }
                if (distinctCount == k) {
                    result++;
                }
                while (distinctCount > k) {
                    if (--charCount[s[start]] == 0) {
                        distinctCount--;
                    }
                    start++;
                }
            }
        }

        return result;
    }
};