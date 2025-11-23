import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;

class Solution {
    public int makeArrayIncreasing(int[] arr1, int[] arr2) {
        Arrays.sort(arr2);
        Map<Integer, Integer> dp = new HashMap<>();
        dp.put(-1, 0);

        for (int num : arr1) {
            Map<Integer, Integer> newDp = new HashMap<>();
            for (Map.Entry<Integer, Integer> entry : dp.entrySet()) {
                int prev = entry.getKey();
                int ops = entry.getValue();
                if (num > prev) {
                    int currentMin = newDp.getOrDefault(num, Integer.MAX_VALUE);
                    newDp.put(num, Math.min(currentMin, ops));
                }
                int idx = binarySearch(arr2, prev);
                if (idx < arr2.length) {
                    int currentMin = newDp.getOrDefault(arr2[idx], Integer.MAX_VALUE);
                    newDp.put(arr2[idx], Math.min(currentMin, ops + 1));
                }
            }
            dp = newDp;
            if (dp.isEmpty()) {
                return -1;
            }
        }

        int result = Integer.MAX_VALUE;
        for (int ops : dp.values()) {
            result = Math.min(result, ops);
        }
        return result;
    }

    private int binarySearch(int[] arr, int target) {
        int left = 0, right = arr.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] > target) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}