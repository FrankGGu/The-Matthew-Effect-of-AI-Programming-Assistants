import java.util.TreeSet;

class Solution {
    public long sumImbalanceNumbers(int[] nums) {
        int n = nums.length;
        long totalImbalance = 0;

        for (int i = 0; i < n; i++) {
            TreeSet<Integer> distinctElements = new TreeSet<>();
            int currentImbalance = 0;

            for (int j = i; j < n; j++) {
                int val = nums[j];

                if (!distinctElements.contains(val)) {
                    distinctElements.add(val);

                    Integer prev = distinctElements.lower(val); // Largest element strictly less than val
                    Integer next = distinctElements.higher(val); // Smallest element strictly greater than val

                    // Update currentImbalance based on the new element and its neighbors among distinct elements.
                    // An imbalance is a pair (x, y) where x, y are adjacent distinct elements and y - x > 1.

                    // Case 1: val is inserted between prev and next.
                    // If (prev, next) was an imbalance (next - prev > 1), it is now broken by val.
                    // So, decrement imbalance count.
                    if (prev != null && next != null) {
                        if (next - prev > 1) {
                            currentImbalance--;
                        }
                    }

                    // Case 2: val forms a new imbalance with prev.
                    // If prev exists and val - prev > 1, then (prev, val) is a new imbalance.
                    // So, increment imbalance count.
                    if (prev != null && val - prev > 1) {
                        currentImbalance++;
                    }

                    // Case 3: val forms a new imbalance with next.
                    // If next exists and next - val > 1, then (val, next) is a new imbalance.
                    // So, increment imbalance count.
                    if (next != null && next - val > 1) {
                        currentImbalance++;
                    }
                }
                // If 'val' is already present in 'distinctElements', adding a duplicate does not change
                // the set of distinct elements or the gaps between them. Thus, 'currentImbalance' remains unchanged.

                totalImbalance += currentImbalance;
            }
        }

        return totalImbalance;
    }
}