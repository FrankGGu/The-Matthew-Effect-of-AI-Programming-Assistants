public class Solution {

import java.util.*;

public class Solution {
    public boolean isItPossible(String s, String t) {
        int[] countS = new int[26];
        int[] countT = new int[26];

        for (char c : s.toCharArray()) {
            countS[c - 'a']++;
        }

        for (char c : t.toCharArray()) {
            countT[c - 'a']++;
        }

        for (int i = 0; i < 26; i++) {
            if (countS[i] == 0) continue;
            for (int j = 0; j < 26; j++) {
                if (countT[j] == 0) continue;

                // Swap i and j
                countS[i]--;
                countT[j]--;
                countS[j]++;
                countT[i]++;

                int distinctS = 0;
                int distinctT = 0;

                for (int k = 0; k < 26; k++) {
                    if (countS[k] > 0) distinctS++;
                    if (countT[k] > 0) distinctT++;
                }

                if (distinctS == distinctT) {
                    return true;
                }

                // Revert the swap
                countS[i]++;
                countT[j]++;
                countS[j]--;
                countT[i]--;
            }
        }

        return false;
    }
}
}