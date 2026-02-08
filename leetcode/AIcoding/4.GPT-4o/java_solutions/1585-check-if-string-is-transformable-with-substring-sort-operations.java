class Solution {
    public boolean isTransformable(String s, String t) {
        if (s.length() != t.length()) return false;
        int[] count = new int[10];

        for (char c : s.toCharArray()) count[c - '0']++;
        for (char c : t.toCharArray()) {
            if (--count[c - '0'] < 0) return false;
        }

        int[] pos = new int[10];
        for (int i = 0; i < s.length(); i++) {
            pos[s.charAt(i) - '0']++;
        }

        for (int i = 0; i < t.length(); i++) {
            for (int j = 0; j < t.charAt(i) - '0'; j++) {
                if (pos[j] > 0) return false;
            }
            pos[t.charAt(i) - '0']--;
        }

        return true;
    }
}