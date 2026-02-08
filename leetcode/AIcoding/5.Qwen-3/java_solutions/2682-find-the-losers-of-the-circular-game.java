public class Solution {

import java.util.*;

public class Solution {
    public int[] findLosers(int[] skills) {
        int n = skills.length;
        List<Integer> players = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            players.add(i);
        }

        int round = 1;
        while (players.size() > 1) {
            int index = (round - 1) % players.size();
            int winner = players.get(index);
            int loser = players.remove((index + 1) % players.size());
            round++;
        }

        int[] result = new int[n - players.size()];
        for (int i = 0; i < result.length; i++) {
            result[i] = players.get(i);
        }
        return result;
    }
}
}