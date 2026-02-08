class Solution {
public:
    int getMinSwaps(string num, int k) {
        string original = num;
        for (int i = 0; i < k; ++i) {
            next_permutation(num.begin(), num.end());
        }
        int swaps = 0;
        for (int i = 0; i < num.size(); ++i) {
            if (num[i] != original[i]) {
                int j = i + 1;
                while (j < num.size() && num[j] != original[i]) {
                    ++j;
                }
                while (j > i) {
                    swap(num[j], num[j - 1]);
                    --j;
                    ++swaps;
                }
            }
        }
        return swaps;
    }
};