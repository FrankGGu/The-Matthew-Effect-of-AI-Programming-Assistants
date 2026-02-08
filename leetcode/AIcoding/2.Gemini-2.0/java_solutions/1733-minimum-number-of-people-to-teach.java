import java.util.*;

class Solution {
    public int minimumTeachings(int n, int[][] languages, int[][] friendships) {
        Set<Integer> needTeach = new HashSet<>();
        for (int[] friendship : friendships) {
            int u = friendship[0] - 1;
            int v = friendship[1] - 1;
            boolean canCommunicate = false;
            for (int langU : languages[u]) {
                for (int langV : languages[v]) {
                    if (langU == langV) {
                        canCommunicate = true;
                        break;
                    }
                }
                if (canCommunicate) {
                    break;
                }
            }
            if (!canCommunicate) {
                needTeach.add(u);
                needTeach.add(v);
            }
        }

        int minTeach = Integer.MAX_VALUE;
        for (int i = 1; i <= n; i++) {
            int teachCount = 0;
            Set<Integer> teachPeople = new HashSet<>();
            for (int person : needTeach) {
                boolean hasLanguage = false;
                for (int lang : languages[person]) {
                    if (lang == i) {
                        hasLanguage = true;
                        break;
                    }
                }
                if (!hasLanguage) {
                    teachPeople.add(person);
                }
            }
            teachCount = teachPeople.size();
            minTeach = Math.min(minTeach, teachCount);
        }

        return minTeach;
    }
}