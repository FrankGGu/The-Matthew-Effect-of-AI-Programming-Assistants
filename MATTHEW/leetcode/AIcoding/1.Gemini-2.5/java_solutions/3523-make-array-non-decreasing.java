import java.util.PriorityQueue;

class Solution {
    public long minCost(int[] nums) {
        long cost = 0;
        // A max-priority queue is used to maintain candidates for the non-decreasing sequence.
        // It helps in efficiently finding the largest element we've committed to so far.
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a); // Max-heap

        for (int num : nums) {
            // If the current number 'num' is smaller than the largest element in our
            // "committed" non-decreasing sequence (pq.peek()), it means we have a violation.
            // To fix this, we must adjust the previous larger element down to 'num'.
            // This incurs a cost equal to the difference.
            if (!pq.isEmpty() && pq.peek() > num) {
                cost += pq.peek() - num; // Add the cost to reduce the previous larger element
                pq.poll(); // Remove the larger element from the heap
                pq.add(num); // Add 'num' to replace the adjusted larger element
            }
            // Always add the current number to the priority queue.
            // This 'num' is a candidate for the current position in the non-decreasing sequence.
            pq.add(num);
        }

        return cost;
    }
}