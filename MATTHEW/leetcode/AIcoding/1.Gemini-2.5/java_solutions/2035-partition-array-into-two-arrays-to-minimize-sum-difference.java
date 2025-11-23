import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {

    public int minimumDifference(int[] nums) {
        int n = nums.length / 2;
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        int[] half1 = new int[n];
        int[] half2 = new int[n];
        for (int i = 0; i < n; i++) {
            half1[i] = nums[i];
            half2[i] = nums[i + n];
        }

        List<List<Integer>> sums1 = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            sums1.add(new ArrayList<>());
        }
        generateSums(0, 0, 0, n, half1, sums1);

        List<List<Integer>> sums2 = new ArrayList<>();
        for (int i = 0; i <= n; i++) {
            sums2.add(new ArrayList<>());
        }
        generateSums(0, 0, 0, n, half2, sums2);

        for (int i = 0; i <= n; i++) {
            Collections.sort(sums2.get(i));
        }

        long minDiff = Long.MAX_VALUE;

        for (int k = 0; k <= n; k++) {
            List<Integer> list1 = sums1.get(k);
            List<Integer> list2 = sums2.get(n - k); 

            for (int s1 : list1) {
                long target = (totalSum / 2) - s1;

                int idx = Collections.binarySearch(list2, (int) target);

                if (idx >= 0) {
                    int s2 = list2.get(idx);
                    long currentSum1 = (long) s1 + s2;
                    minDiff = Math.min(minDiff, Math.abs(totalSum - 2 * currentSum1));
                } else {
                    int insertionPoint = -idx - 1;

                    if (insertionPoint < list2.size()) {
                        int s2 = list2.get(insertionPoint);
                        long currentSum1 = (long) s1 + s2;
                        minDiff = Math.min(minDiff, Math.abs(totalSum - 2 * currentSum1));
                    }
                    if (insertionPoint > 0) {
                        int s2 = list2.get(insertionPoint - 1);
                        long currentSum1 = (long) s1 + s2;
                        minDiff = Math.min(minDiff, Math.abs(totalSum - 2 * currentSum1));
                    }
                }
            }
        }

        return (int) minDiff;
    }

    private void generateSums(int index, int currentSum, int count, int limit, int[] currentHalf, List<List<Integer>> sumsList) {
        if (index == limit) {
            sumsList.get(count).add(currentSum);
            return;
        }

        generateSums(index + 1, currentSum + currentHalf[index], count + 1, limit, currentHalf, sumsList);

        generateSums(index + 1, currentSum, count, limit, currentHalf, sumsList);
    }
}