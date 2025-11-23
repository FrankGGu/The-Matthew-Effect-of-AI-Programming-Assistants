class Solution {
public:
    string minInteger(string num, int k) {
        int n = num.size();
        for (int i = 0; i < n && k > 0; ++i) {
            char minChar = num[i];
            int minIndex = i;
            for (int j = i + 1; j < n && j <= i + k; ++j) {
                if (num[j] < minChar) {
                    minChar = num[j];
                    minIndex = j;
                }
            }
            if (minIndex != i) {
                for (int j = minIndex; j > i; --j) {
                    swap(num[j], num[j - 1]);
                }
                k -= (minIndex - i);
            }
        }
        return num;
    }
};