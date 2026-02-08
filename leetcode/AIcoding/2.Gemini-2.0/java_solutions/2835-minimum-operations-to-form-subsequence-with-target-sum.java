import java.util.List;

class Solution {
    public int minOperations(List<Integer> nums, int target) {
        int sum = 0;
        List<Integer> bits = new java.util.ArrayList<>();
        for (int num : nums) {
            sum += num;
            if (num > 0) {
                bits.add(Integer.highestOneBit(num));
            }
        }

        if (sum < target) {
            return -1;
        }

        java.util.Collections.sort(bits);

        int operations = 0;
        int currentSum = 0;
        for (int i = bits.size() - 1; i >= 0; i--) {
            int bit = bits.get(i);
            if (currentSum + bit <= target) {
                currentSum += bit;
            }
        }

        if (currentSum < target) {
            return -1;
        }

        currentSum = 0;
        for (int i = bits.size() - 1; i >= 0; i--) {
            int bit = bits.get(i);
            if (currentSum + bit <= target) {
                currentSum += bit;
            } else {
                operations++;
                int j = i;
                while (j < bits.size() - 1 && bits.get(j) != bits.get(j + 1) * 2) {
                    bits.set(j + 1, bits.get(j) * 2);
                    operations++;
                    j++;
                }
            }
        }

        return operations;
    }
}