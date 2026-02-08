class Solution {
    public int countPalindromicSubsequence(String s) {
        int[] first = new int[26];
        int[] last = new int[26];
        Arrays.fill(first, Integer.MAX_VALUE);
        Arrays.fill(last, -1);

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            first[c - 'a'] = Math.min(first[c - 'a'], i);
            last[c - 'a'] = Math.max(last[c - 'a'], i);
        }

        int res = 0;
        for (int i = 0; i < 26; i++) {
            if (first[i] < last[i]) {
                Set<Character> set = new HashSet<>();
                for (int j = first[i] + 1; j < last[i]; j++) {
                    set.add(s.charAt(j));
                }
                res += set.size();
            }
        }
        return res;
    }
}