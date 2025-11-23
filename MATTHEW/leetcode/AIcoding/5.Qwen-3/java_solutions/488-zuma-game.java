public class Solution {

import java.util.*;

public class Solution {
    public int findMinStep(String target, String hand) {
        Map<String, Integer> memo = new HashMap<>();
        Set<String> visited = new HashSet<>();
        return dfs(target, hand, memo, visited);
    }

    private int dfs(String target, String hand, Map<String, Integer> memo, Set<String> visited) {
        if (target.length() == 0) return 0;
        if (hand.length() == 0) return -1;

        String key = target + "," + hand;
        if (memo.containsKey(key)) return memo.get(key);

        int minSteps = Integer.MAX_VALUE;
        for (int i = 0; i < hand.length(); i++) {
            char c = hand.charAt(i);
            String newHand = hand.substring(0, i) + hand.substring(i + 1);
            for (int j = 0; j <= target.length(); j++) {
                String newTarget = target.substring(0, j) + c + target.substring(j);
                if (newTarget.equals(target)) continue;
                String nextTarget = removeConsecutive(newTarget);
                if (visited.contains(nextTarget)) continue;
                visited.add(nextTarget);
                int steps = dfs(nextTarget, newHand, memo, visited);
                if (steps != -1) {
                    minSteps = Math.min(minSteps, 1 + steps);
                }
                visited.remove(nextTarget);
            }
        }

        if (minSteps == Integer.MAX_VALUE) {
            memo.put(key, -1);
            return -1;
        } else {
            memo.put(key, minSteps);
            return minSteps;
        }
    }

    private String removeConsecutive(String s) {
        boolean changed;
        do {
            changed = false;
            StringBuilder sb = new StringBuilder();
            int i = 0;
            while (i < s.length()) {
                int j = i;
                while (j < s.length() && s.charAt(j) == s.charAt(i)) j++;
                if (j - i >= 3) {
                    changed = true;
                } else {
                    sb.append(s.substring(i, j));
                }
                i = j;
            }
            s = sb.toString();
        } while (changed);
        return s;
    }
}
}