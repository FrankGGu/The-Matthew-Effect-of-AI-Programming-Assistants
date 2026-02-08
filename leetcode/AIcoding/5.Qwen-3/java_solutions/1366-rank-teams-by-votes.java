public class Solution {

import java.util.*;

public class Solution {
    public String rankTeams(int[][] votes) {
        if (votes.length == 0) return "";

        int[] count = new int[26];
        for (int i = 0; i < 26; i++) {
            count[i] = 0;
        }

        for (int[] vote : votes) {
            for (int j = 0; j < vote.length; j++) {
                count[vote[j]]++;
            }
        }

        Character[] team = new Character[26];
        for (int i = 0; i < 26; i++) {
            team[i] = (char) ('a' + i);
        }

        Arrays.sort(team, (a, b) -> {
            for (int i = 0; i < 26; i++) {
                int aCount = 0;
                int bCount = 0;
                for (int[] vote : votes) {
                    for (int j = 0; j < vote.length; j++) {
                        if (vote[j] == a) aCount++;
                        if (vote[j] == b) bCount++;
                    }
                }
                if (aCount != bCount) {
                    return bCount - aCount;
                }
            }
            return a - b;
        });

        StringBuilder sb = new StringBuilder();
        for (char c : team) {
            if (count[c - 'a'] > 0) {
                sb.append(c);
            }
        }

        return sb.toString();
    }
}
}