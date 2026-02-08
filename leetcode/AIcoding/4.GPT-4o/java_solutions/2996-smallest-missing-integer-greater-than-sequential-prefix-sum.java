import java.util.HashSet;

class Solution {
    public int findSmallestInteger(int[] nums) {
        HashSet<Integer> set = new HashSet<>();
        int prefixSum = 0;
        for (int num : nums) {
            prefixSum += num;
            set.add(prefixSum);
        }

        int smallestMissing = 1;
        while (set.contains(smallestMissing)) {
            smallestMissing++;
        }

        return smallestMissing;
    }
}