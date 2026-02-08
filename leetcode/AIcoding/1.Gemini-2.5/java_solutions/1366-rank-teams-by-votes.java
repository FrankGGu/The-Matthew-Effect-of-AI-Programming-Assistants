import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

class Solution {
    public String rankTeams(String[] votes) {
        if (votes == null || votes.length == 0) {
            return "";
        }

        int numTeams = votes[0].length();
        Map<Character, int[]> teamRankCounts = new HashMap<>();

        for (char team : votes[0].toCharArray()) {
            teamRankCounts.put(team, new int[numTeams]);
        }

        for (String vote : votes) {
            for (int i = 0; i < numTeams; i++) {
                char team = vote.charAt(i);
                teamRankCounts.get(team)[i]++;
            }
        }

        List<Character> teams = new ArrayList<>(teamRankCounts.keySet());

        Collections.sort(teams, new Comparator<Character>() {
            @Override
            public int compare(Character t1, Character t2) {
                int[] counts1 = teamRankCounts.get(t1);
                int[] counts2 = teamRankCounts.get(t2);

                for (int i = 0; i < numTeams; i++) {
                    if (counts1[i] != counts2[i]) {
                        return counts2[i] - counts1[i]; // Sort by higher vote count for this rank
                    }
                }
                return t1 - t2; // If all ranks are tied, sort alphabetically
            }
        });

        StringBuilder result = new StringBuilder();
        for (char team : teams) {
            result.append(team);
        }

        return result.toString();
    }
}