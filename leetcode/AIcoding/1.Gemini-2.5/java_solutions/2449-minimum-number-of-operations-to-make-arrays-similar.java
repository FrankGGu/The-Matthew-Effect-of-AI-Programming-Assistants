import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public long minimumOperations(int[] nums, int[] target) {
        List<Integer> numsEven = new ArrayList<>();
        List<Integer> numsOdd = new ArrayList<>();
        List<Integer> targetEven = new ArrayList<>();
        List<Integer> targetOdd = new ArrayList<>();

        for (int num : nums) {
            if (num % 2 == 0) {
                numsEven.add(num);
            } else {
                numsOdd.add(num);
            }
        }

        for (int num : target) {
            if (num % 2 == 0) {
                targetEven.add(num);
            } else {
                targetOdd.add(num);
            }
        }

        Collections.sort(numsEven);
        Collections.sort(numsOdd);
        Collections.sort(targetEven);
        Collections.sort(targetOdd);

        long totalChange = 0;

        for (int i = 0; i < numsEven.size(); i++) {
            totalChange += Math.abs(numsEven.get(i) - targetEven.get(i));
        }

        for (int i = 0; i < numsOdd.size(); i++) {
            totalChange += Math.abs(numsOdd.get(i) - targetOdd.get(i));
        }

        return totalChange / 2;
    }
}