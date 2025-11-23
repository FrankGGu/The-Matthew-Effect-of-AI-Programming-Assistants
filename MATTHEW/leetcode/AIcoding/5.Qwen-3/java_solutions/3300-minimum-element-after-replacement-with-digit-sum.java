public class Solution {

import java.util.*;

public class Solution {
    public int minElement(int[] nums, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int num : nums) {
            pq.add(num);
        }

        while (k > 0) {
            int min = pq.poll();
            int sum = 0;
            int temp = min;
            while (temp > 0) {
                sum += temp % 10;
                temp /= 10;
            }
            pq.add(sum);
            k--;
        }

        return pq.peek();
    }
}
}