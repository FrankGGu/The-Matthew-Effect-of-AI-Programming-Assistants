import java.util.*;

class Solution {
    public String rankTeams(String[] votes) {
        if (votes.length == 0) {
            return "";
        }
        if (votes[0].length() == 1) {
            return votes[0];
        }

        int numTeams = votes[0].length();
        Map<Character, int[]> rankMap = new HashMap<>();
        for (char c : votes[0].toCharArray()) {
            rankMap.put(c, new int[numTeams]);
        }

        for (String vote : votes) {
            for (int i = 0; i < numTeams; i++) {
                char team = vote.charAt(i);
                rankMap.get(team)[i]++;
            }
        }

        List<Character> teams = new ArrayList<>(rankMap.keySet());
        Collections.sort(teams, (a, b) -> {
            for (int i = 0; i < numTeams; i++) {
                if (rankMap.get(a)[i] != rankMap.get(b)[i]) {
                    return rankMap.get(b)[i] - rankMap.get(a)[i];
                }
            }
            return a - b;
        });

        StringBuilder result = new StringBuilder();
        for (char team : teams) {
            result.append(team);
        }

        return result.toString();
    }
}