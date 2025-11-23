class Solution {
    public boolean isIsomorphic(String s, String t) {
        if (s.length() != t.length()) {
            return false;
        }

        int[] sToT = new int[256];
        int[] tToS = new int[256];

        for (int i = 0; i < s.length(); i++) {
            char sChar = s.charAt(i);
            char tChar = t.charAt(i);

            if (sToT[sChar] != 0 && sToT[sChar] != tChar) {
                return false;
            }
            if (tToS[tChar] != 0 && tToS[tChar] != sChar) {
                return false;
            }

            sToT[sChar] = tChar;
            tToS[tChar] = sChar;
        }

        return true;
    }
}