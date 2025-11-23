class Solution {
    public boolean isIsomorphic(String s, String t) {
        int[] sToT = new int[256];
        int[] tToS = new int[256];

        for (int i = 0; i < s.length(); i++) {
            char c1 = s.charAt(i);
            char c2 = t.charAt(i);

            if (sToT[c1] == 0) {
                sToT[c1] = c2;
            } else if (sToT[c1] != c2) {
                return false;
            }

            if (tToS[c2] == 0) {
                tToS[c2] = c1;
            } else if (tToS[c2] != c1) {
                return false;
            }
        }

        return true;
    }
}