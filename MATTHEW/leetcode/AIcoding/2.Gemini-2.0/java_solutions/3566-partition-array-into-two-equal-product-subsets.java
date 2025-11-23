import java.util.HashMap;
import java.util.Map;

class Solution {
    public boolean canPartition(int[] nums) {
        int n = nums.length;
        if (n <= 1) return false;

        long product = 1;
        for (int num : nums) {
            product *= num;
        }

        if (product < 0) return true;
        if (product == 0) {
            int zeroCount = 0;
            for (int num : nums) {
                if (num == 0) {
                    zeroCount++;
                }
            }
            return zeroCount >= 2;
        }

        if (product == 1) return true;

        Map<Long, Integer> leftMap = new HashMap<>();
        Map<Long, Integer> rightMap = new HashMap<>();

        for (int i = 0; i < (1 << (n / 2)); i++) {
            long currentProduct = 1;
            int count = 0;
            for (int j = 0; j < n / 2; j++) {
                if ((i & (1 << j)) != 0) {
                    currentProduct *= nums[j];
                    count++;
                }
            }
            leftMap.put(currentProduct, leftMap.getOrDefault(currentProduct, 0) + 1);
        }

        for (int i = 0; i < (1 << (n - n / 2)); i++) {
            long currentProduct = 1;
            int count = 0;
            for (int j = 0; j < n - n / 2; j++) {
                if ((i & (1 << j)) != 0) {
                    currentProduct *= nums[n / 2 + j];
                    count++;
                }
            }
            rightMap.put(currentProduct, rightMap.getOrDefault(currentProduct, 0) + 1);
        }

        for (long leftProduct : leftMap.keySet()) {
            if (rightMap.containsKey(product / leftProduct)) {
                return true;
            }
        }

        return false;
    }
}