class Solution {
public:
    int getAntsPosition(int n, int m, int t) {
        int x = t % (2 * n);
        int y = t % (2 * m);
        if (x <= n) {
            if (y <= m) return x + 1; 
            return x + m - (y - m);
        }
        if (y <= m) return 2 * n - x + 1; 
        return 2 * n + m - (y - m);
    }
};