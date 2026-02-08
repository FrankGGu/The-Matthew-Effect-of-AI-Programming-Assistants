class Solution {
    private int max = 0;

    public int maxUniqueSplit(String s) {
        backtrack(s, 0, new HashSet<>());
        return max;
    }

    private void backtrack(String s, int start, Set<String> set) {
        if (start == s.length()) {
            max = Math.max(max, set.size());
            return;
        }

        for (int end = start + 1; end <= s.length(); end++) {
            String substring = s.substring(start, end);
            if (!set.contains(substring)) {
                set.add(substring);
                backtrack(s, end, set);
                set.remove(substring);
            }
        }
    }
}