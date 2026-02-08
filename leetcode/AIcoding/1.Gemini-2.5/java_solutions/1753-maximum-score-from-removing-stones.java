import java.util.Arrays;

class Solution {
    public int maximumScore(int a, int b, int c) {
        int[] piles = {a, b, c};
        Arrays.sort(piles);

        int x = piles[0];
        int y = piles[1];
        int z = piles[2];

        // Case 1: The largest pile is too big.
        // We can exhaust the two smaller piles by pairing them with the largest pile.
        // The total score will be the sum of the two smaller piles.
        // Example: (1, 2, 10). We remove (2,10) once -> (1,1,9). Remove (1,9) once -> (1,0,8). Remove (1,8) once -> (0,0,7).
        // Score = 1+2 = 3.
        // This holds if x + y <= z.
        if (x + y <= z) {
            return x + y;
        } 
        // Case 2: The piles are relatively balanced.
        // We can always keep two piles non-empty until at most one stone remains in total.
        // Each operation removes 2 stones.
        // So, the total number of operations is (total stones) / 2.
        // Example: (3, 3, 3). Total stones = 9. Score = 9/2 = 4 (integer division).
        // Example: (2, 2, 2). Total stones = 6. Score = 6/2 = 3.
        else { // x + y > z
            return (x + y + z) / 2;
        }
    }
}