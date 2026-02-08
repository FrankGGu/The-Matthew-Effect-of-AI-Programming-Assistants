import java.util.TreeSet;
import java.util.Comparator;

class Solution {

    // Custom class to store value and its original index.
    // This is necessary because TreeSet only stores unique elements based on its comparator,
    // and we need to handle duplicate values in the input array by differentiating them
    // using their indices. When an element leaves the window, we need to remove the
    // specific instance (value at a specific index).
    static class Element {
        long val;
        int idx;

        Element(long val, int idx) {
            this.val = val;
            this.idx = idx;
        }
    }

    // TreeSet to store the smaller half of the numbers.
    // It behaves like a max-heap: its 'first()' element is the largest among its members.
    // Elements are ordered descending by value, then descending by index for tie-breaking.
    private TreeSet<Element> left; 

    // TreeSet to store the larger half of the numbers.
    // It behaves like a min-heap: its 'first()' element is the smallest among its members.
    // Elements are ordered ascending by value, then ascending by index for tie-breaking.
    private TreeSet<Element> right;

    public double[] medianSlidingWindow(int[] nums, int k) {
        // Comparator for the 'left' TreeSet (max-heap behavior).
        // Orders elements such that the largest value (and largest index for ties) is considered 'first'.
        Comparator<Element> leftComparator = (e1, e2) -> {
            int cmp = Long.compare(e2.val, e1.val); // Descending value
            if (cmp == 0) {
                return Integer.compare(e2.idx, e1.idx); // Descending index for tie-break
            }
            return cmp;
        };

        // Comparator for the 'right' TreeSet (min-heap behavior).
        // Orders elements such that the smallest value (and smallest index for ties) is considered 'first'.
        Comparator<Element> rightComparator = (e1, e2) -> {
            int cmp = Long.compare(e1.val, e2.val); // Ascending value
            if (cmp == 0) {
                return Integer.compare(e1.idx, e2.idx); // Ascending index for tie-break
            }
            return cmp;
        };

        left = new TreeSet<>(leftComparator);
        right = new TreeSet<>(rightComparator);

        double[] result = new double[nums.length - k + 1];

        for (int i = 0; i < nums.length; i++) {
            // Add the current element to one of the TreeSets.
            // By default, try to add to 'left' (smaller half).
            // 'left.first()' gives the largest element in the 'left' set.
            if (left.isEmpty() || nums[i] <= left.first().val) {
                left.add(new Element(nums[i], i));
            } else {
                right.add(new Element(nums[i], i));
            }

            // Balance the TreeSets to maintain the median property.
            balance();

            // Once the window is full (i.e., we have processed 'k' elements),
            // calculate the median and remove the element that is leaving the window.
            if (i >= k - 1) {
                // Calculate median for the current window.
                result[i - (k - 1)] = getMedian();

                // Remove the element that is exiting the window.
                // The element to remove is nums[i - k + 1] at index (i - k + 1).
                Element elementToRemove = new Element(nums[i - k + 1], i - k + 1);

                // Determine which set contains the element and remove it.
                // The 'remove' method uses the TreeSet's comparator to find the element.
                if (left.contains(elementToRemove)) {
                    left.remove(elementToRemove);
                } else {
                    right.remove(elementToRemove);
                }

                // Re-balance after removal.
                balance();
            }
        }

        return result;
    }

    // Balances the two TreeSets to ensure:
    // 1. 'left' contains 'right.size()' or 'right.size() + 1' elements.
    // 2. All elements in 'left' are less than or equal to all elements in 'right'.
    private void balance() {
        // If 'left' has too many elements (more than right.size() + 1),
        // move its largest element (left.first()) to 'right'.
        while (left.size() > right.size() + 1) {
            right.add(left.pollFirst()); 
        }
        // If 'right' has more elements than 'left',
        // move its smallest element (right.first()) to 'left'.
        while (right.size() > left.size()) {
            left.add(right.pollFirst()); 
        }
    }

    // Calculates the median based on the current state of 'left' and 'right' TreeSets.
    private double getMedian() {
        if (left.size() == right.size()) {
            // Even number of elements in the window.
            // Median is the average of the largest element in 'left' and the smallest element in 'right'.
            return ((double) left.first().val + right.first().val) / 2.0;
        } else {
            // Odd number of elements in the window.
            // Median is the largest element in 'left' (which is left.first()).
            return (double) left.first().val;
        }
    }
}