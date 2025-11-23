public class Solution {
    public int[] sortJumbled(int[] arr, int[][] m) {
        int n = arr.length;
        int[][] mapped = new int[n][2];

        for (int i = 0; i < n; i++) {
            int num = arr[i];
            int count = 0;
            while (num > 0) {
                count += num & 1;
                num >>= 1;
            }
            mapped[i][0] = count;
            mapped[i][1] = arr[i];
        }

        for (int i = 0; i < n - 1; i++) {
            for (int j = 0; j < n - i - 1; j++) {
                if (mapped[j][0] > mapped[j + 1][0]) {
                    int[] temp = mapped[j];
                    mapped[j] = mapped[j + 1];
                    mapped[j + 1] = temp;
                }
            }
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = mapped[i][1];
        }

        return result;
    }
}