import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int bestTeamWithNoConflicts(int[] scores, int[] ages) {
        int n = scores.length;
        Player[] players = new Player[n];
        for (int i = 0; i < n; i++) {
            players[i] = new Player(ages[i], scores[i]);
        }

        Arrays.sort(players, new Comparator<Player>() {
            @Override
            public int compare(Player p1, Player p2) {
                if (p1.age != p2.age) {
                    return p1.age - p2.age;
                }
                return p1.score - p2.score;
            }
        });

        int[] dp = new int[n];
        int maxOverallScore = 0;

        for (int i = 0; i < n; i++) {
            dp[i] = players[i].score;
            for (int j = 0; j < i; j++) {
                if (players[j].score <= players[i].score) {
                    dp[i] = Math.max(dp[i], dp[j] + players[i].score);
                }
            }
            maxOverallScore = Math.max(maxOverallScore, dp[i]);
        }

        return maxOverallScore;
    }

    private static class Player {
        int age;
        int score;

        Player(int age, int score) {
            this.age = age;
            this.score = score;
        }
    }
}