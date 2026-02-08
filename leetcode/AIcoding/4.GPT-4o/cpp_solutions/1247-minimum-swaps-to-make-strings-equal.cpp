class Solution {
public:
    int minimumSwaps(string s1, string s2) {
        if (s1.length() != s2.length()) return -1;
        int x_count = 0, y_count = 0;
        for (int i = 0; i < s1.length(); i++) {
            if (s1[i] != s2[i]) {
                if (s1[i] == 'x') x_count++;
                else y_count++;
            }
        }
        if ((x_count + y_count) % 2 != 0) return -1;
        return (x_count + 1) / 2 + (y_count + 1) / 2;
    }
};