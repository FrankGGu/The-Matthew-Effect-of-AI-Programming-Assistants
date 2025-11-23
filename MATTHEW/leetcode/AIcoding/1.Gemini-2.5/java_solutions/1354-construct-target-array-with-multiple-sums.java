import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    public boolean isPossible(int[] target) {
        PriorityQueue<Long> pq = new PriorityQueue<>(Collections.reverseOrder());
        long sum = 0;

        for (int num : target) {
            pq.add((long) num);
            sum += num;
        }

        while (pq.peek() != 1) {
            long max_val = pq.poll();
            long sum_others = sum - max_val;

            // If sum_others is 0, it means the array contains only one element.
            // If that element is not 1, it's impossible. (e.g., target = [5])
            // If it is 1, the loop would have terminated earlier.
            if (sum_others == 0) {
                return false;
            }

            // The largest element (max_val) must have been formed by adding sum_others
            // to a previous value (prev_max_val).
            // So, prev_max_val = max_val - sum_others.
            // For prev_max_val to be valid, it must be at least 1.
            // This implies max_val - sum_others >= 1, or max_val > sum_others.
            // If max_val <= sum_others, it's impossible to get a positive prev_max_val.
            if (max_val <= sum_others) {
                return false;
            }

            // Calculate the previous value of max_val using modulo for efficiency.
            // This is equivalent to repeatedly subtracting sum_others from max_val
            // until it's less than sum_others but still positive.
            long prev_max_val = max_val % sum_others;

            // If prev_max_val is 0, it means max_val was an exact multiple of sum_others.
            // In this case, the previous value should be sum_others itself.
            // Example: [10, 2]. max_val=10, sum_others=2. 10 % 2 = 0.
            // The sequence was 2 -> 4 -> 6 -> 8 -> 10. So previous was 2.
            // If sum_others is 1 (e.g., [5, 1]), then 5 % 1 = 0, prev_max_val becomes 1. Correct.
            if (prev_max_val == 0) {
                prev_max_val = sum_others;
            }

            // Update the total sum.
            sum = sum - max_val + prev_max_val;
            // Add the new value back to the priority queue.
            pq.add(prev_max_val);
        }

        return true;
    }
}