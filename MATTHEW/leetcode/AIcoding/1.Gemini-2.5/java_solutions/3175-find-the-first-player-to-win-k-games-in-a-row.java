import java.util.Deque;
import java.util.LinkedList;

class Solution {
    public int getWinner(int[] arr, int k) {
        if (k >= arr.length - 1) {
            int maxVal = 0;
            for (int num : arr) {
                if (num > maxVal) {
                    maxVal = num;
                }
            }
            return maxVal;
        }

        Deque<Integer> q = new LinkedList<>();
        for (int num : arr) {
            q.addLast(num);
        }

        int currentWinner = q.pollFirst();
        int consecutiveWins = 0;

        while (true) {
            int challenger = q.pollFirst();

            if (currentWinner > challenger) {
                consecutiveWins++;
                q.addLast(challenger);
            } else {
                q.addLast(currentWinner);
                currentWinner = challenger;
                consecutiveWins = 1;
            }

            if (consecutiveWins == k) {
                return currentWinner;
            }
        }
    }
}