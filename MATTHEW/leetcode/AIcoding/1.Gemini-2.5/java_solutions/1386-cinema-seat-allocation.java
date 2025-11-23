import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class Solution {
    public int maxNumberOfFamilies(int n, int[][] reservedSeats) {
        Map<Integer, Set<Integer>> rowToReservedCols = new HashMap<>();

        for (int[] seat : reservedSeats) {
            int row = seat[0];
            int col = seat[1];
            rowToReservedCols.computeIfAbsent(row, k -> new HashSet<>()).add(col);
        }

        int totalFamilies = (n - rowToReservedCols.size()) * 2; // For rows with no reservations, 2 families can always be seated

        for (int row : rowToReservedCols.keySet()) {
            Set<Integer> reservedCols = rowToReservedCols.get(row);
            int familiesInThisRow = 0;

            // Check for two non-overlapping groups: (2,3,4,5) and (6,7,8,9)
            boolean leftAisleFree = !reservedCols.contains(2) && !reservedCols.contains(3) && !reservedCols.contains(4) && !reservedCols.contains(5);
            boolean rightAisleFree = !reservedCols.contains(6) && !reservedCols.contains(7) && !reservedCols.contains(8) && !reservedCols.contains(9);

            if (leftAisleFree && rightAisleFree) {
                familiesInThisRow = 2;
            } else if (leftAisleFree || rightAisleFree) {
                familiesInThisRow = 1;
            } else {
                // If neither of the non-overlapping pairs is fully free, check the middle overlapping group (4,5,6,7)
                boolean middleAisleFree = !reservedCols.contains(4) && !reservedCols.contains(5) && !reservedCols.contains(6) && !reservedCols.contains(7);
                if (middleAisleFree) {
                    familiesInThisRow = 1;
                }
            }
            totalFamilies += familiesInThisRow;
        }

        return totalFamilies;
    }
}