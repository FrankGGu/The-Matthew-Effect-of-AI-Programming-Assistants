class Solution {
public:
    int maxProduct(vector<string>& words) {
        int n = words.size();
        vector<int> masks(n);
        vector<int> lengths(n);

        for (int i = 0; i < n; ++i) {
            for (char c : words[i]) {
                masks[i] |= 1 << (c - 'a');
            }
            lengths[i] = words[i].length();
        }

        int maxProduct = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if ((masks[i] & masks[j]) == 0) {
                    maxProduct = max(maxProduct, lengths[i] * lengths[j]);
                }
            }
        }

        return maxProduct;
    }
};