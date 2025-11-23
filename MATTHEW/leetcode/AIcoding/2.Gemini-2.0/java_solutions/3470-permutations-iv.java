import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class PermutationsIV {

    public int permutation(List<Integer> nums) {
        Map<Integer, Integer> counts = new HashMap<>();
        for (int num : nums) {
            counts.put(num, counts.getOrDefault(num, 0) + 1);
        }

        return permutationHelper(counts, nums.size());
    }

    private int permutationHelper(Map<Integer, Integer> counts, int remaining) {
        if (remaining == 0) {
            return 1;
        }

        int permutations = 0;
        for (int num : counts.keySet()) {
            if (counts.get(num) > 0) {
                counts.put(num, counts.get(num) - 1);
                permutations += permutationHelper(counts, remaining - 1);
                counts.put(num, counts.get(num) + 1);
            }
        }

        return permutations;
    }