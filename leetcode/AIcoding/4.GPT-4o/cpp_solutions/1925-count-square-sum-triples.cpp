class Solution {
public:
    int countTriples(int n) {
        int count = 0;
        for (int a = 1; a <= n; ++a) {
            for (int b = a; b <= n; ++b) {
                int c2 = a * a + b * b;
                int c = sqrt(c2);
                if (c * c == c2 && c <= n) {
                    count += (a == b) ? 1 : 2; // a == b contributes 1, otherwise 2
                }
            }
        }
        return count;
    }
};