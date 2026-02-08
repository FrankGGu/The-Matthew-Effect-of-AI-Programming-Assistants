import java.util.*;

class Solution {
    public int[] sortJumbled(int[] mapping, int[] nums) {
        int n = nums.length;
        Integer[] indices = new Integer[n];
        for (int i = 0; i < n; i++) {
            indices[i] = i;
        }

        Arrays.sort(indices, (a, b) -> {
            long mappedA = map(nums[a], mapping);
            long mappedB = map(nums[b], mapping);
            return Long.compare(mappedA, mappedB);
        });

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = nums[indices[i]];
        }

        return result;
    }

    private long map(int num, int[] mapping) {
        if (num == 0) {
            return mapping[0];
        }

        long mappedNum = 0;
        long powerOfTen = 1;
        while (num > 0) {
            int digit = num % 10;
            mappedNum += (long)mapping[digit] * powerOfTen;
            powerOfTen *= 10;
            num /= 10;
        }

        return mappedNum;
    }
}