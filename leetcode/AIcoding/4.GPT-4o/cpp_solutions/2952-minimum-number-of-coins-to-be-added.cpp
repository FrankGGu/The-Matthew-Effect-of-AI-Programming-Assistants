class Solution {
public:
    int addMinimum(string word) {
        int count = 0;
        char expected = 'a';

        for (char c : word) {
            while (expected < c) {
                count++;
                expected++;
            }
            if (expected == c) {
                expected++;
            }
        }
        while (expected <= 'c') {
            count++;
            expected++;
        }

        return count;
    }
};