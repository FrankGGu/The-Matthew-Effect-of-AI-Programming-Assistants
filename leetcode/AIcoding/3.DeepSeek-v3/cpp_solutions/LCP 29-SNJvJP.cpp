class Solution {
public:
    int orchestraLayout(int num, int xPos, int yPos) {
        long long n = num;
        long long x = xPos;
        long long y = yPos;
        long long layer = min(min(x, n - 1 - x), min(y, n - 1 - y));
        long long total = 4 * layer * (n - layer);
        long long side = n - 2 * layer;

        if (x == layer && y < n - layer - 1) {
            total += y - layer + 1;
        } else if (y == n - layer - 1 && x < n - layer - 1) {
            total += side - 1 + x - layer + 1;
        } else if (x == n - layer - 1 && y > layer) {
            total += 2 * (side - 1) + (n - layer - 1 - y) + 1;
        } else {
            total += 3 * (side - 1) + (n - layer - 1 - x) + 1;
        }

        return (total - 1) % 9 + 1;
    }
};