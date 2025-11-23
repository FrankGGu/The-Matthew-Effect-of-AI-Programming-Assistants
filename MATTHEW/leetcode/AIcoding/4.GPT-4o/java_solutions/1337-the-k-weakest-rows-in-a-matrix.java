import java.util.Arrays;
import java.util.Comparator;

public class Solution {
    public int[] kWeakestRows(int[][] mat, int k) {
        int[] strength = new int[mat.length];
        for (int i = 0; i < mat.length; i++) {
            strength[i] = Arrays.stream(mat[i]).sum();
        }
        Integer[] indices = new Integer[strength.length];
        for (int i = 0; i < strength.length; i++) {
            indices[i] = i;
        }
        Arrays.sort(indices, Comparator.comparingInt(i -> strength[i]));
        return Arrays.stream(indices).limit(k).mapToInt(i -> i).toArray();
    }
}