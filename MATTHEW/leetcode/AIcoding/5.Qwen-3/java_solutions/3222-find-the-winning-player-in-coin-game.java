public class Solution {

import java.util.*;

public class Solution {
    public String findTheWinningPlayer(int n, int x) {
        int[] coins = new int[n];
        Arrays.fill(coins, 1);
        int turn = 0;
        while (true) {
            int player = turn % 2;
            int count = 0;
            for (int i = 0; i < n; i++) {
                if (coins[i] > 0) {
                    count++;
                    if (count == x) {
                        coins[i]--;
                        turn++;
                        break;
                    }
                }
            }
            if (count < x) {
                return player == 0 ? "Player 1" : "Player 2";
            }
        }
    }
}
}