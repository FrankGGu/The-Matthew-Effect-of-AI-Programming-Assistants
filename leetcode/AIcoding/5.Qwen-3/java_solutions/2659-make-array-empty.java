public class Solution {

import java.util.*;

public class Solution {
    public int findCounter(int[] nums) {
        Map<Integer, Integer> count = new HashMap<>();
        for (int num : nums) {
            count.put(num, count.getOrDefault(num, 0) + 1);
        }
        int maxCount = 0;
        for (int key : count.keySet()) {
            if (count.get(key) > maxCount) {
                maxCount = count.get(key);
            }
        }
        return maxCount;
    }

    public int[] getFinalArray(int[] nums) {
        List<Integer> list = new ArrayList<>();
        for (int num : nums) {
            list.add(num);
        }
        int n = list.size();
        int[] result = new int[n];
        int index = 0;
        while (!list.isEmpty()) {
            List<Integer> temp = new ArrayList<>();
            for (int i = 0; i < list.size(); i++) {
                if (i == 0 || list.get(i) != list.get(i - 1)) {
                    temp.add(list.get(i));
                }
            }
            for (int i = 0; i < temp.size(); i++) {
                result[index++] = temp.get(i);
            }
            list = temp;
        }
        return result;
    }

    public int arrayOperations(int[] nums) {
        int operations = 0;
        int n = nums.length;
        int[] result = getFinalArray(nums);
        for (int i = 0; i < n; i++) {
            if (result[i] != 0) {
                operations++;
            }
        }
        return operations;
    }

    public int makeArrayEmpty(int[] nums) {
        int n = nums.length;
        int[] result = getFinalArray(nums);
        int operations = 0;
        for (int i = 0; i < n; i++) {
            if (result[i] != 0) {
                operations++;
            }
        }
        return operations;
    }
}
}