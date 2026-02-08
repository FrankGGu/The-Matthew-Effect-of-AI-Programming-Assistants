class Solution {
    public int minSwapsCouples(int[] row) {
        int n = row.length;
        int ans = 0;
        int[] pos = new int[n];
        for (int i = 0; i < n; i++) {
            pos[row[i]] = i;
        }

        for (int i = 0; i < n; i += 2) {
            int first = row[i];
            int second;
            if (first % 2 == 0) {
                second = first + 1;
            } else {
                second = first - 1;
            }

            if (row[i + 1] != second) {
                int swapIndex = pos[second];
                int temp = row[i + 1];
                row[swapIndex] = temp;
                pos[temp] = swapIndex;
                ans++;
            }
        }

        return ans;
    }
}