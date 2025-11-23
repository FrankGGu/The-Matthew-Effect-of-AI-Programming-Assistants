class Solution {
public:
    int maxRepOpt1(string text) {
        unordered_map<char, int> count;
        for (char c : text) count[c]++;

        int max_len = 0, n = text.size();
        for (int i = 0; i < n; ) {
            char current = text[i];
            int start = i;
            while (i < n && text[i] == current) i++;
            int length = i - start;
            max_len = max(max_len, length + (count[current] > length ? 1 : 0));
            if (i < n) {
                int j = i;
                while (j < n && text[j] == text[i]) j++;
                max_len = max(max_len, length + min(j - i, 1));
            }
        }
        return max_len;
    }
};