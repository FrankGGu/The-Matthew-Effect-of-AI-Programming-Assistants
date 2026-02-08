import java.util.PriorityQueue;

class Solution {
    public int magicTower(int[] nums) {
        long totalSum = 0;
        for (int num : nums) {
            totalSum += num;
        }

        if (totalSum < 0) {
            return -1;
        }

        long currentHp = 0;
        int moves = 0;
        PriorityQueue<Integer> pq = new PriorityQueue<>(); // Min-priority queue to store negative health changes

        for (int num : nums) {
            currentHp += num;
            if (num < 0) {
                pq.offer(num);
            }

            // If current HP drops below 0, we must move a negative room to recover.
            // To minimize initial HP, we should move the room that caused the most damage (most negative value)
            // as this gives the biggest HP boost back.
            while (currentHp < 0) {
                int valToMove = pq.poll(); // Get the most negative (smallest) value
                currentHp -= valToMove;    // Remove its effect from currentHp (effectively moving it to the end)
                moves++;                   // Increment the count of moved rooms
            }
        }

        // The minimum initial HP required is 1 (to ensure HP >= 1 at all times for the non-moved rooms)
        // plus the total cost of moving rooms (each move costs 1 HP).
        return 1 + moves;
    }
}