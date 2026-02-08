class Solution {
    public boolean canMakeSquare(int[][] pieces) {
        int[] count = new int[6];
        for (int[] piece : pieces) {
            for (int num : piece) {
                count[num]++;
            }
        }
        return checkSquare(count, 0, 0, 0);
    }

    private boolean checkSquare(int[] count, int index, int used, int side) {
        if (side == 4) return true;
        if (index == 6) return false;
        if (count[index] > 0) {
            for (int i = 0; i < count[index]; i++) {
                if (used + index > 3) return false;
                if (checkSquare(count, index + 1, used + index, side + (used + index == 3 ? 1 : 0))) {
                    return true;
                }
            }
        }
        return checkSquare(count, index + 1, used, side);
    }
}