public class Solution {

import java.util.*;

public class Solution {
    public long minOperations(int[] nums, int[] target) {
        List<Integer> numsList = new ArrayList<>();
        for (int num : nums) {
            numsList.add(num);
        }
        List<Integer> targetList = new ArrayList<>();
        for (int num : target) {
            targetList.add(num);
        }

        Collections.sort(numsList);
        Collections.sort(targetList);

        long operations = 0;
        int n = numsList.size();

        for (int i = 0; i < n; i++) {
            if (numsList.get(i) == targetList.get(i)) {
                continue;
            }
            if (numsList.get(i) > targetList.get(i)) {
                operations += (numsList.get(i) - targetList.get(i));
            } else {
                operations += (targetList.get(i) - numsList.get(i));
            }
        }

        return operations;
    }
}
}