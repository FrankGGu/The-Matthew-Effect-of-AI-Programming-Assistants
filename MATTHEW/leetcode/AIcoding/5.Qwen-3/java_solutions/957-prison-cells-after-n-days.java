public class Solution {
    public int[] prisonAfterNDays(int[] cells, int N) {
        int[] result = new int[cells.length];
        for (int i = 0; i < cells.length; i++) {
            result[i] = cells[i];
        }
        int day = 1;
        while (day <= N) {
            int[] nextDay = new int[cells.length];
            for (int i = 1; i < cells.length - 1; i++) {
                if (result[i - 1] == result[i + 1]) {
                    nextDay[i] = 1;
                } else {
                    nextDay[i] = 0;
                }
            }
            result = nextDay;
            day++;
        }
        return result;
    }
}