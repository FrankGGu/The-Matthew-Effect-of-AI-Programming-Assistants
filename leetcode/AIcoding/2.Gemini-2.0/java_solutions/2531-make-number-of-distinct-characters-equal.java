class Solution {
    public boolean isItPossible(String word1, String word2) {
        int[] count1 = new int[26];
        int[] count2 = new int[26];
        for (char c : word1.toCharArray()) {
            count1[c - 'a']++;
        }
        for (char c : word2.toCharArray()) {
            count2[c - 'a']++;
        }
        int distinct1 = 0;
        for (int i = 0; i < 26; i++) {
            if (count1[i] > 0) {
                distinct1++;
            }
        }
        int distinct2 = 0;
        for (int i = 0; i < 26; i++) {
            if (count2[i] > 0) {
                distinct2++;
            }
        }

        for (int i = 0; i < 26; i++) {
            if (count1[i] == 0) continue;
            for (int j = 0; j < 26; j++) {
                if (count2[j] == 0) continue;
                int newDistinct1 = distinct1;
                int newDistinct2 = distinct2;

                if (i == j) {
                    if (newDistinct1 == newDistinct2) return true;
                    else continue;
                }

                if (count1[i] == 1) {
                    newDistinct1--;
                }
                if (count1[j] == 0) {
                    newDistinct1++;
                }

                if (count2[j] == 1) {
                    newDistinct2--;
                }
                if (count2[i] == 0) {
                    newDistinct2++;
                }

                if (newDistinct1 == newDistinct2) return true;
            }
        }

        return false;
    }
}