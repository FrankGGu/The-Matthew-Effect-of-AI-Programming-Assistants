import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class Solution {
    public List<Integer> intersection(int[][] nums) {
        HashMap<Integer, Integer> count = new HashMap<>();
        List<Integer> result = new ArrayList<>();
        int arrayCount = nums.length;

        for (int[] arr : nums) {
            for (int num : arr) {
                count.put(num, count.getOrDefault(num, 0) + 1);
            }
        }

        for (int key : count.keySet()) {
            if (count.get(key) == arrayCount) {
                result.add(key);
            }
        }

        return result;
    }
}