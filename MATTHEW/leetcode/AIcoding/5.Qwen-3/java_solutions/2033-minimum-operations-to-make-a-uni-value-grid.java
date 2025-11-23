public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[][] grid) {
        List<Integer> flat = new ArrayList<>();
        for (int[] row : grid) {
            for (int num : row) {
                flat.add(num);
            }
        }
        Collections.sort(flat);
        int median = flat.get(flat.size() / 2);
        int operations = 0;
        for (int num : flat) {
            operations += Math.abs(num - median);
        }
        return operations;
    }
}
}