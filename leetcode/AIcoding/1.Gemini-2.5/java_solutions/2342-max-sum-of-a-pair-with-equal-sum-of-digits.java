import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class Solution {
    private int getDigitSum(int n) {
        int sum = 0;
        while (n > 0) {
            sum += n % 10;
            n /= 10;
        }
        return sum;
    }

    public int maximumSum(int[] nums) {
        Map<Integer, PriorityQueue<Integer>> digitSumToNumbers = new HashMap<>();
        int maxSum = -1;

        for (int num : nums) {
            int currentDigitSum = getDigitSum(num);
            digitSumToNumbers.putIfAbsent(currentDigitSum, new PriorityQueue<>());
            PriorityQueue<Integer> pq = digitSumToNumbers.get(currentDigitSum);

            pq.offer(num);
            if (pq.size() > 2) {
                pq.poll(); // Keep only the two largest numbers
            }
        }

        for (PriorityQueue<Integer> pq : digitSumToNumbers.values()) {
            if (pq.size() == 2) {
                int num1 = pq.poll();
                int num2 = pq.poll();
                maxSum = Math.max(maxSum, num1 + num2);
            }
        }

        return maxSum;
    }
}