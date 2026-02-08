import java.util.ArrayList;
import java.util.List;

class Solution {
    public List<List<Integer>> reconstructMatrix(int upper, int lower, int[] colsum) {
        int n = colsum.length;
        int[] row0 = new int[n];
        int[] row1 = new int[n];

        for (int j = 0; j < n; j++) {
            if (colsum[j] == 2) {
                row0[j] = 1;
                row1[j] = 1;
                upper--;
                lower--;
            } else if (colsum[j] == 1) {
                if (upper > 0) {
                    row0[j] = 1;
                    upper--;
                } else {
                    row1[j] = 1;
                    lower--;
                }
            }
        }

        if (upper == 0 && lower == 0) {
            List<List<Integer>> result = new ArrayList<>();
            List<Integer> list0 = new ArrayList<>();
            for (int val : row0) {
                list0.add(val);
            }
            List<Integer> list1 = new ArrayList<>();
            for (int val : row1) {
                list1.add(val);
            }
            result.add(list0);
            result.add(list1);
            return result;
        } else {
            return new ArrayList<>();
        }
    }
}