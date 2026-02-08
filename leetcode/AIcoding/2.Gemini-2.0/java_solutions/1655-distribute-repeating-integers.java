import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public boolean canDistribute(int[] nums, int[] quantity) {
        Map<Integer, Integer> countMap = new HashMap<>();
        for (int num : nums) {
            countMap.put(num, countMap.getOrDefault(num, 0) + 1);
        }

        int[] counts = new int[countMap.size()];
        int i = 0;
        for (int count : countMap.values()) {
            counts[i++] = count;
        }

        Arrays.sort(quantity);
        reverse(quantity);

        return canDistributeHelper(counts, quantity, 0);
    }

    private boolean canDistributeHelper(int[] counts, int[] quantity, int index) {
        if (index == quantity.length) {
            return true;
        }

        for (int i = 0; i < counts.length; i++) {
            if (counts[i] >= quantity[index]) {
                counts[i] -= quantity[index];
                if (canDistributeHelper(counts, quantity, index + 1)) {
                    return true;
                }
                counts[i] += quantity[index];
            }
        }

        return false;
    }

    private void reverse(int[] arr) {
        int start = 0;
        int end = arr.length - 1;
        while (start < end) {
            int temp = arr[start];
            arr[start] = arr[end];
            arr[end] = temp;
            start++;
            end--;
        }
    }
}