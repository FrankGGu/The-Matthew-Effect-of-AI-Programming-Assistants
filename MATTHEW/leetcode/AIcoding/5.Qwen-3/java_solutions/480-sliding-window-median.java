public class Solution {

import java.util.*;

public class Solution {
    public double[] medianSlidingWindow(int[] nums, int k) {
        int n = nums.length;
        double[] result = new double[n - k + 1];
        int index = 0;

        TreeSet<Integer> left = new TreeSet<>();
        TreeSet<Integer> right = new TreeSet<>();

        for (int i = 0; i < n; i++) {
            int num = nums[i];

            if (left.isEmpty() || num <= left.last()) {
                left.add(num);
            } else {
                right.add(num);
            }

            if (left.size() > right.size() + 1) {
                right.add(left.pollLast());
            } else if (right.size() > left.size()) {
                left.add(right.pollFirst());
            }

            if (i >= k - 1) {
                if (k % 2 == 1) {
                    result[index++] = left.last();
                } else {
                    result[index++] = (double) (left.last() + right.first()) / 2;
                }

                int removeNum = nums[i - k + 1];
                if (left.contains(removeNum)) {
                    left.remove(removeNum);
                } else {
                    right.remove(removeNum);
                }

                if (left.size() > right.size() + 1) {
                    right.add(left.pollLast());
                } else if (right.size() > left.size()) {
                    left.add(right.pollFirst());
                }
            }
        }

        return result;
    }
}
}