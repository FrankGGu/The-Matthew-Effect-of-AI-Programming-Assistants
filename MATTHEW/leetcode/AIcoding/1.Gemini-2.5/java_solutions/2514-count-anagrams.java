class Solution {
    public int countAnagrams(String s, String p) {
        if (p.length() == 0 || s.length() == 0 || p.length() > s.length()) {
            return 0;
        }

        int[] pFreq = new int[26];
        for (char c : p.toCharArray()) {
            pFreq[c - 'a']++;
        }

        int windowStart = 0;
        int count = 0;
        int charToMatch = p.length(); 

        for (int windowEnd = 0; windowEnd < s.length(); windowEnd++) {
            char charEnd = s.charAt(windowEnd);
            int idxEnd = charEnd - 'a';

            if (pFreq[idxEnd] > 0) {
                charToMatch--;
            }
            pFreq[idxEnd]--;

            if (windowEnd - windowStart + 1 == p.length()) {
                if (charToMatch == 0) {
                    count++;
                }

                char charStart = s.charAt(windowStart);
                int idxStart = charStart - 'a';

                if (pFreq[idxStart] == 0) {
                    charToMatch++;
                }
                pFreq[idxStart]++;
                windowStart++;
            }
        }

        return count;
    }
}