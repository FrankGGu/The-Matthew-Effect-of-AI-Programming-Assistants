class Solution {
public:
    int maxProduct(vector<string>& words) {
        int n = words.size();
        vector<int> masks(n, 0);
        for (int i = 0; i < n; ++i) {
            for (char c : words[i]) {
                masks[i] |= 1 << (c - 'a');
            }
        }
        int maxProd = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if ((masks[i] & masks[j]) == 0) {
                    int prod = words[i].size() * words[j].size();
                    if (prod > maxProd) {
                        maxProd = prod;
                    }
                }
            }
        }
        return maxProd;
    }
};