class Solution {
    public int orchestraLayout(int num, int row, int col) {
        long level = Math.min(Math.min(row, col), Math.min(num - 1 - row, num - 1 - col));
        long len = num - 2 * level;
        long total = (num * 4L - 4) * level - 4 * level * level + 4 * level;
        row -= level;
        col -= level;
        if (row == 0) {
            total += col + 1;
        } else if (col == len - 1) {
            total += len + row;
        } else if (row == len - 1) {
            total += 2 * len + (len - 1 - col);
        } else {
            total += 3 * len - 1 + (len - 1 - row);
        }
        return (int) (total % 9 + 1);
    }
}