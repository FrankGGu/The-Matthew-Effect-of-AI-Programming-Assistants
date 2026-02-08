import java.util.*;

class Solution {
    public String rankTeams(String[] votes) {
        int n = votes[0].length();
        Map<Character, int[]> map = new HashMap<>();

        for (String vote : votes) {
            for (int i = 0; i < n; i++) {
                char team = vote.charAt(i);
                map.putIfAbsent(team, new int[n]);
                map.get(team)[i]++;
            }
        }

        List<Character> teams = new ArrayList<>(map.keySet());
        Collections.sort(teams, (a, b) -> {
            for (int i = 0; i < n; i++) {
                if (map.get(a)[i] != map.get(b)[i]) {
                    return map.get(b)[i] - map.get(a)[i];
                }
            }
            return a - b;
        });

        StringBuilder sb = new StringBuilder();
        for (char team : teams) {
            sb.append(team);
        }
        return sb.toString();
    }
}