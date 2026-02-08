class Solution {
public:
    int minSwaps(string s) {
        int balance = 0;
        int swaps = 0;
        int j = s.size() - 1;
        for (int i = 0; i < s.size(); ++i) {
            if (s[i] == '[') {
                balance++;
            } else {
                balance--;
            }
            if (balance < 0) {
                while (i < j && s[j] != '[') {
                    j--;
                }
                swap(s[i], s[j]);
                swaps++;
                balance = 1;
            }
        }
        return swaps;
    }
};