class Solution {
public:
    int longestBeautifulSubstring(string word) {
        int max_len = 0;
        int n = word.size();
        int count = 1;
        int len = 1;

        for (int i = 1; i < n; ++i) {
            if (word[i] > word[i-1]) {
                len++;
                count++;
            } else if (word[i] == word[i-1]) {
                len++;
            } else {
                len = 1;
                count = 1;
            }

            if (count == 5) {
                max_len = max(max_len, len);
            }
        }

        return max_len;
    }
};