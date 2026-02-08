class Solution {
    public String longestSubsequenceRepeatedK(String s, int k) {
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        List<Character> possibleChars = new ArrayList<>();
        for (int i = 0; i < 26; i++) {
            if (freq[i] >= k) {
                possibleChars.add((char)('a' + i));
            }
        }
        String res = "";
        Queue<String> queue = new LinkedList<>();
        queue.offer("");
        while (!queue.isEmpty()) {
            String curr = queue.poll();
            for (char c : possibleChars) {
                String next = curr + c;
                if (isSubsequenceRepeatedK(s, next, k)) {
                    if (next.length() > res.length() || (next.length() == res.length() && next.compareTo(res) > 0)) {
                        res = next;
                    }
                    queue.offer(next);
                }
            }
        }
        return res;
    }

    private boolean isSubsequenceRepeatedK(String s, String sub, int k) {
        int count = 0;
        int j = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == sub.charAt(j)) {
                j++;
                if (j == sub.length()) {
                    count++;
                    j = 0;
                    if (count == k) {
                        return true;
                    }
                }
            }
        }
        return false;
    }
}