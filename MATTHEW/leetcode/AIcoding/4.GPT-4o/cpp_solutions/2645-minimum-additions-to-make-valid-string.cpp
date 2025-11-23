class Solution {
public:
    int addMinimum(string word) {
        int count = 0;
        char expected = 'a';

        for (char c : word) {
            while (expected != c) {
                count++;
                expected = (expected == 'c') ? 'a' : expected + 1;
            }
            expected = (expected == 'c') ? 'a' : expected + 1;
        }

        while (expected != 'a') {
            count++;
            expected = (expected == 'c') ? 'a' : expected + 1;
        }

        return count;
    }
};