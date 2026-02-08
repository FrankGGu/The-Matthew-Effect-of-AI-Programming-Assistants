import java.util.Arrays;

class Solution {
    public int maxNumberOfFamilies(int n, int[][] reservedSeats) {
        Arrays.sort(reservedSeats, (a, b) -> a[0] - b[0]);
        int ans = n * 2;
        int lastRow = 0;
        boolean[] occupied = new boolean[10];
        for (int[] seat : reservedSeats) {
            int row = seat[0], col = seat[1];
            if (row != lastRow) {
                if (lastRow != 0) {
                    if (!occupied[1] && !occupied[2] && !occupied[3] && !occupied[4]) {
                        ans++;
                    }
                    if (!occupied[5] && !occupied[6] && !occupied[7] && !occupied[8]) {
                        ans++;
                    } else if (!occupied[3] && !occupied[4] && !occupied[5] && !occupied[6]) {
                        ans++;
                    }
                }
                lastRow = row;
                Arrays.fill(occupied, false);
            }
            occupied[col - 1] = true;
        }
        if (lastRow != 0) {
            if (!occupied[1] && !occupied[2] && !occupied[3] && !occupied[4]) {
                ans++;
            }
            if (!occupied[5] && !occupied[6] && !occupied[7] && !occupied[8]) {
                ans++;
            } else if (!occupied[3] && !occupied[4] && !occupied[5] && !occupied[6]) {
                ans++;
            }
        }
        return ans;
    }
}