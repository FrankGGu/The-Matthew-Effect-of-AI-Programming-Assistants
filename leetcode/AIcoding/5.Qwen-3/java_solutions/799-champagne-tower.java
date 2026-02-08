public class Solution {
    public int champagneTower(int poured, int queryRow, int queryGlass) {
        double[][] tower = new double[101][101];
        tower[0][0] = poured;
        for (int row = 0; row <= queryRow; row++) {
            for (int glass = 0; glass <= row; glass++) {
                if (tower[row][glass] > 1) {
                    tower[row + 1][glass] += (tower[row][glass] - 1) / 2;
                    tower[row + 1][glass + 1] += (tower[row][glass] - 1) / 2;
                    tower[row][glass] = 1;
                }
            }
        }
        return (int) Math.floor(tower[queryRow][queryGlass]);
    }
}