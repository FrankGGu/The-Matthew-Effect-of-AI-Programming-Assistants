class Solution {
public:
    int minimumDeletions(string s) {
        int count_a = 0, count_b = 0;
        for (char c : s) {
            if (c == 'a') {
                count_a++;
            } else {
                count_b++;
            }
            if (count_b > count_a) {
                count_b--;
            }
        }
        return count_b;
    }
};