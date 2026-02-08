import java.util.*;

class Solution {
    public boolean pyramidTransition(String bottom, List<String> allowed) {
        Map<String, Set<Character>> map = new HashMap<>();
        for (String s : allowed) {
            String key = s.substring(0, 2);
            char val = s.charAt(2);
            map.computeIfAbsent(key, k -> new HashSet<>()).add(val);
        }
        return solve(bottom, map);
    }

    private boolean solve(String row, Map<String, Set<Character>> map) {
        if (row.length() == 1) {
            return true;
        }

        List<String> nextRows = new ArrayList<>();
        generateNextRows(row, 0, new StringBuilder(), map, nextRows);

        for (String nextRow : nextRows) {
            if (solve(nextRow, map)) {
                return true;
            }
        }

        return false;
    }

    private void generateNextRows(String row, int index, StringBuilder current, Map<String, Set<Character>> map, List<String> nextRows) {
        if (index == row.length() - 1) {
            if (current.length() > 0) {
               nextRows.add(current.toString());
            }
            return;
        }

        String key = row.substring(index, index + 2);
        if (map.containsKey(key)) {
            for (char c : map.get(key)) {
                current.append(c);
                generateNextRows(row, index + 1, current, map, nextRows);
                current.deleteCharAt(current.length() - 1);
            }
        }
    }
}