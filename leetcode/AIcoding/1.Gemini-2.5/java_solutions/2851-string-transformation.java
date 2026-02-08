class Solution {
    public boolean isIsomorphic(String s, String t) {
        if (s.length() != t.length()) {
            return false;
        }

        int[] mapS = new int[256]; // Stores mapping from char in s to char in t
        int[] mapT = new int[256]; // Stores mapping from char in t to char in s

        for (int i = 0; i < s.length(); i++) {
            char charS = s.charAt(i);
            char charT = t.charAt(i);

            // Check mapping from s to t
            if (mapS[charS] == 0) { // No mapping for charS yet
                mapS[charS] = charT;
            } else { // Mapping for charS exists
                if (mapS[charS] != charT) { // Mismatch with existing mapping
                    return false;
                }
            }

            // Check mapping from t to s
            if (mapT[charT] == 0) { // No mapping for charT yet
                mapT[charT] = charS;
            } else { // Mapping for charT exists
                if (mapT[charT] != charS) { // Mismatch with existing mapping
                    return false;
                }
            }
        }

        return true;
    }
}