class Solution {
    public boolean isItPossible(String word1, String word2) {
        int[] count1 = new int[26];
        int[] count2 = new int[26];

        for (char c : word1.toCharArray()) count1[c - 'a']++;
        for (char c : word2.toCharArray()) count2[c - 'a']++;

        int distinct1 = 0, distinct2 = 0;
        for (int i = 0; i < 26; i++) {
            if (count1[i] > 0) distinct1++;
            if (count2[i] > 0) distinct2++;
        }

        for (int i = -1; i <= 1; i++) {
            int newDistinct1 = distinct1 + i;
            int newDistinct2 = distinct2 - i;
            if (newDistinct1 >= 0 && newDistinct2 >= 0 && newDistinct1 == newDistinct2) {
                return true;
            }
        }

        return false;
    }
}