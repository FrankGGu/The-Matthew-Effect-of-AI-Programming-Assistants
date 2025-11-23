class Solution {
public:
    int longestString(int x, int y, int z) {
        int mn = min(x, y);
        if (x == y) {
            return (x + y + z) * 2;
        } else {
            return (2 * mn + 1 + z) * 2;
        }
    }
};