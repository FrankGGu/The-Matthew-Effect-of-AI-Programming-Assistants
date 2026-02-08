class Solution {
public:
    int orchestraLayout(int num, int row, int col) {
        long long layer = min(min(row, col), min(num - 1 - row, num - 1 - col));
        long long len = num - 2 * layer;
        long long start = (layer % 3 == 0) ? 1 : ((layer % 3 == 1) ? 2 : 3);

        long long pos = (2 * num - 4 * layer) * layer;

        if (row == layer) {
            pos += (col - layer + 1);
        } else if (col == num - 1 - layer) {
            pos += (len + row - layer);
        } else if (row == num - 1 - layer) {
            pos += (2 * len + num - 1 - layer - col);
        } else {
            pos += (3 * len + num - 1 - layer - row);
        }

        return (start + (pos - 1)) % 3 + 1;
    }
};