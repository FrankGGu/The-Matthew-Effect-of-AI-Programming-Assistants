import java.util.Arrays;
import java.util.Comparator;
import java.util.HashSet;
import java.util.Objects;
import java.util.PriorityQueue;
import java.util.Set;

class Solution {
    class Pair {
        long sum;
        int index;

        public Pair(long sum, int index) {
            this.sum = sum;
            this.index = index;
        }

        @Override
        public boolean equals(Object o) {
            if (this == o) return true;
            if (o == null || getClass() != o.getClass()) return false;
            Pair pair = (Pair) o;
            return sum == pair.sum && index == pair.index;
        }

        @Override
        public int hashCode() {
            return Objects.hash(sum, index);
        }
    }

    public long kSum(int[] nums, int k) {
        long maxPossibleSum = 0;
        int n = nums.length;
        long[] absNums = new long[n];
        long sumOfAllAbs = 0;

        for (int i = 0; i < n; i++) {
            if (nums[i] >= 0) {
                maxPossibleSum += nums[i];
            }
            absNums[i] = Math.abs(nums[i]);
            sumOfAllAbs += absNums[i];
        }

        Arrays.sort(absNums);

        PriorityQueue<Pair> pq = new PriorityQueue<>(Comparator.comparingLong(a -> a.sum));
        Set<Pair> visited = new HashSet<>();

        pq.offer(new Pair(0L, -1));
        visited.add(new Pair(0L, -1));

        long kthSmallestAbsSubsequenceSum = 0;
        for (int count = 0; count < k; count++) {
            Pair current = pq.poll();
            kthSmallestAbsSubsequenceSum = current.sum;

            int lastIdx = current.index;

            if (lastIdx + 1 < n) {
                Pair nextPair1 = new Pair(current.sum + absNums[lastIdx + 1], lastIdx + 1);
                if (!visited.contains(nextPair1)) {
                    pq.offer(nextPair1);
                    visited.add(nextPair1);
                }
            }

            if (lastIdx != -1 && lastIdx + 1 < n) {
                Pair nextPair2 = new Pair(current.sum - absNums[lastIdx] + absNums[lastIdx + 1], lastIdx + 1);
                if (!visited.contains(nextPair2)) {
                    pq.offer(nextPair2);
                    visited.add(nextPair2);
                }
            }
        }

        return maxPossibleSum - (sumOfAllAbs - kthSmallestAbsSubsequenceSum);
    }
}