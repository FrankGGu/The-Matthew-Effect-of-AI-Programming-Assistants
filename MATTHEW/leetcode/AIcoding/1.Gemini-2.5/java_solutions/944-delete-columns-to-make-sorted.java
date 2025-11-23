class Solution {
    public int minDeletionSize(String[] strs) {
        if (strs == null || strs.length == 0) {
            return 0;
        }

        int numRows = strs.length;
        int numCols = strs[0].length();
        int deletedColumnCount = 0;

        for (int j = 0; j < numCols; j++) { // Iterate through each column
            for (int i = 0; i < numRows - 1; i++) { // Iterate through rows to check order
                if (strs[i].charAt(j) > strs[i + 1].charAt(j)) {
                    deletedColumnCount++;
                    break; // This column is not sorted, move to the next column
                }
            }
        }

        return deletedColumnCount;
    }
}