import java.util.*;

class Solution {
    static class FenwickTree {
        int[] bit;
        int size;

        public FenwickTree(int size) {
            this.size = size;
            bit = new int[size + 1]; // 1-indexed
        }

        // Adds 'val' to the element at 'idx' (0-indexed)
        public void update(int idx, int val) {
            idx++; // Convert to 1-indexed
            while (idx <= size) {
                bit[idx] += val;
                idx += idx & (-idx);
            }
        }

        // Gets sum of elements from index 0 to 'idx' (0-indexed)
        public int query(int idx) {
            idx++; // Convert to 1-indexed
            int sum = 0;
            while (idx > 0) {
                sum += bit[idx];
                idx -= idx & (-idx);
            }
            return sum;
        }

        // Gets sum of elements from 'left' to 'right' (inclusive, 0-indexed)
        public int queryRange(int left, int right) {
            if (left > right) return 0;
            return query(right) - query(left - 1);
        }
    }

    public long countAlmostEqualPairs(int[] nums, int k) {
        // Step 1: Collect all relevant values for coordinate compression.
        // These include original numbers, and their bounds for 'almost equal' condition.
        Set<Long> values = new TreeSet<>();
        for (int num : nums) {
            values.add((long) num);
            values.add((long) num - k);
            values.add((long) num + k);
        }

        // Step 2: Map unique sorted values to compressed ranks (0-indexed).
        Map<Long, Integer> valToRank = new HashMap<>();
        int rank = 0;
        for (long val : values) {
            valToRank.put(val, rank++);
        }

        // Step 3: Initialize Fenwick Tree with the size of unique ranks.
        FenwickTree ft = new FenwickTree(rank);
        long count = 0;

        // Step 4: Iterate through nums, query for elements in the valid range, and update BIT.
        for (int num : nums) {
            long lowerBound = (long) num - k;
            long upperBound = (long) num + k;

            // Get the compressed ranks for the lower and upper bounds.
            // Since `values` contains `num - k` and `num + k`, these exact bounds will have ranks.
            int lowRank = valToRank.get(lowerBound);
            int highRank = valToRank.get(upperBound);

            // Query the Fenwick Tree to count numbers already processed (to the left)
            // that fall within the current number's 'almost equal' range.
            count += ft.queryRange(lowRank, highRank);

            // Add the current number's rank to the Fenwick Tree.
            // This marks its presence for future queries.
            int currentNumRank = valToRank.get((long) num);
            ft.update(currentNumRank, 1);
        }

        return count;
    }
}