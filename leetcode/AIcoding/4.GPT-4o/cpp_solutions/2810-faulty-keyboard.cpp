class Solution {
public:
    bool isFaultyKeyboard(string typed, string expected) {
        int i = 0, j = 0;
        while (i < typed.size() && j < expected.size()) {
            if (typed[i] == expected[j]) {
                j++;
            }
            i++;
        }
        return j == expected.size();
    }
};