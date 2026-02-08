import java.util.*;

class Solution {
    public int[] findArray(int[] pref) {
        int n = pref.length;
        int[] original = new int[n];
        original[0] = pref[0];

        for (int i = 1; i < n; i++) {
            original[i] = pref[i] ^ pref[i - 1];
        }

        return original;
    }
}