class Solution {
public:
    int longestDecomposition(string text) {
        int n = text.size();
        int count = 0;
        for (int i = 0; i < n / 2; ++i) {
            if (text[i] == text[n - 1 - i]) {
                count++;
            } else {
                break;
            }
        }
        if (count == 0) return n > 0 ? 1 : 0;
        return 2 * count + longestDecomposition(text.substr(count, n - 2 * count));
    }
};