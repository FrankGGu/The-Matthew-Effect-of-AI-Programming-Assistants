import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.HashSet;
import java.util.Collections;

class Solution {
    public List<Integer> circularGameLosers(int n, int k) {
        boolean[] received = new boolean[n + 1]; // Using 1-based indexing

        int currentFriend = 1;
        received[currentFriend] = true;

        int round = 1;

        while (true) {
            int nextFriend = (currentFriend - 1 + round * k) % n + 1;

            if (received[nextFriend]) {
                break; // Game stops
            }

            received[nextFriend] = true;
            currentFriend = nextFriend;
            round++;
        }

        List<Integer> losers = new ArrayList<>();
        for (int i = 1; i <= n; i++) {
            if (!received[i]) {
                losers.add(i);
            }
        }

        return losers;
    }
}