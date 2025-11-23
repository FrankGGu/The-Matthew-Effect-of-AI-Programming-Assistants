import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    public long makeSimilar(int[] nums, int[] target) {
        List<Integer> oddNums = new ArrayList<>();
        List<Integer> evenNums = new ArrayList<>();
        List<Integer> oddTarget = new ArrayList<>();
        List<Integer> evenTarget = new ArrayList<>();

        for (int num : nums) {
            if (num % 2 == 0) {
                evenNums.add(num);
            } else {
                oddNums.add(num);
            }
        }

        for (int num : target) {
            if (num % 2 == 0) {
                evenTarget.add(num);
            } else {
                oddTarget.add(num);
            }
        }

        Collections.sort(oddNums);
        Collections.sort(evenNums);
        Collections.sort(oddTarget);
        Collections.sort(evenTarget);

        long ops = 0;
        for (int i = 0; i < oddNums.size(); i++) {
            if (oddNums.get(i) > oddTarget.get(i)) {
                ops += (oddNums.get(i) - oddTarget.get(i)) / 2;
            }
        }

        for (int i = 0; i < evenNums.size(); i++) {
            if (evenNums.get(i) > evenTarget.get(i)) {
                ops += (evenNums.get(i) - evenTarget.get(i)) / 2;
            }
        }

        return ops;
    }
}