import java.math.BigInteger;
import java.util.PriorityQueue;
import java.util.Comparator;

class Solution {
    public String kthLargestNumber(String[] nums, int k) {
        // Custom comparator for strings representing numbers
        // It compares based on length first, then lexicographically for same length.
        // This comparator defines "less than" for numerical values.
        // For example, "9" is less than "10", "100" is greater than "99".
        Comparator<String> numStringComparator = (s1, s2) -> {
            if (s1.length() != s2.length()) {
                return s1.length() - s2.length();
            }
            return s1.compareTo(s2);
        };

        // A min-priority queue (min-heap) of size k.
        // The comparator ensures that the "smallest" numerical string (e.g., "3" < "10")
        // is at the top of the heap.
        PriorityQueue<String> minHeap = new PriorityQueue<>(numStringComparator);

        for (String num : nums) {
            minHeap.offer(num); // Add the current number string to the heap
            if (minHeap.size() > k) {
                minHeap.poll(); // If heap size exceeds k, remove the smallest element
            }
        }

        // After processing all numbers, the smallest element in the min-heap
        // will be the kth largest number overall.
        return minHeap.peek();
    }
}