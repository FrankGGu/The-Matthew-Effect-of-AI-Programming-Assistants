import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public List<Integer> intersection(int[][] nums) {
        int[] counts = new int[1001]; 

        for (int[] arr : nums) {
            for (int num : arr) {
                counts[num]++;
            }
        }

        List<Integer> result = new ArrayList<>();
        int numArrays = nums.length;

        for (int i = 1; i <= 1000; i++) {
            if (counts[i] == numArrays) {
                result.add(i);
            }
        }

        return result;
    }
}