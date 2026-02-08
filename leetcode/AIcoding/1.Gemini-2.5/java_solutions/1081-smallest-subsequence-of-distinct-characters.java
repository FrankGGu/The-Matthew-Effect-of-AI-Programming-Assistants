class Solution {
    public String smallestSubsequence(String s) {
        int[] counts = new int[26];
        for (char c : s.toCharArray()) {
            counts[c - 'a']++;
        }

        boolean[] inStack = new boolean[26];
        StringBuilder sb = new StringBuilder();

        for (char c : s.toCharArray()) {
            counts[c - 'a']--;

            if (inStack[c - 'a']) {
                continue;
            }

            while (sb.length() > 0 && c < sb.charAt(sb.length() - 1) && counts[sb.charAt(sb.length() - 1) - 'a'] > 0) {
                char poppedChar = sb.charAt(sb.length() - 1);
                sb.deleteCharAt(sb.length() - 1);
                inStack[poppedChar - 'a'] = false;
            }

            sb.append(c);
            inStack[c - 'a'] = true;
        }

        return sb.toString();
    }
}