class Solution {
    public int[] rowAndMaximumOnes(int[][] mat) {
        int maxOnes = -1;
        int rowIndex = 0;
        for (int i = 0; i < mat.length; i++) {
            int count = 0;
            for (int num : mat[i]) {
                if (num == 1) {
                    count++;
                }
            }
            if (count > maxOnes) {
                maxOnes = count;
                rowIndex = i;
            } else if (count == maxOnes && i < rowIndex) {
                rowIndex = i;
            }
        }
        return new int[]{rowIndex, maxOnes};
    }
}