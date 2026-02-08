public class Solution {

import java.util.*;

public class Solution {
    public boolean areMatricesSimilar(int[][] matrix, int[][] target) {
        int rows = matrix.length;
        int cols = matrix[0].length;

        for (int i = 0; i < rows; i++) {
            Set<String> rotations = new HashSet<>();
            String original = Arrays.toString(matrix[i]);
            rotations.add(original);

            int[] temp = Arrays.copyOf(matrix[i], cols);
            for (int j = 0; j < cols; j++) {
                int last = temp[cols - 1];
                for (int k = cols - 1; k > 0; k--) {
                    temp[k] = temp[k - 1];
                }
                temp[0] = last;
                rotations.add(Arrays.toString(temp));
            }

            boolean found = false;
            for (int j = 0; j < rows; j++) {
                if (rotations.contains(Arrays.toString(target[j]))) {
                    found = true;
                    break;
                }
            }

            if (!found) {
                return false;
            }
        }

        return true;
    }
}
}