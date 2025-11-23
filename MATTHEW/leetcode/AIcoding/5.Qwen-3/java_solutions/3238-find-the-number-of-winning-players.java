public class Solution {

import java.util.*;

public class Solution {
    public int[] winningPlayers(int[][] matches) {
        Map<Integer, Integer> scoreMap = new HashMap<>();
        Set<Integer> players = new HashSet<>();

        for (int[] match : matches) {
            int winner = match[0];
            int loser = match[1];
            players.add(winner);
            players.add(loser);

            scoreMap.put(winner, scoreMap.getOrDefault(winner, 0) + 1);
        }

        List<Integer> result = new ArrayList<>();
        for (int player : players) {
            if (scoreMap.get(player) > 0) {
                result.add(player);
            }
        }

        int[] answer = new int[result.size()];
        for (int i = 0; i < answer.length; i++) {
            answer[i] = result.get(i);
        }

        Arrays.sort(answer);
        return answer;
    }
}
}