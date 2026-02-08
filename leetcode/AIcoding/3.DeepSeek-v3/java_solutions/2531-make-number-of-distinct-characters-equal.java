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

        for (int i = 0; i < 26; i++) {
            if (count1[i] == 0) continue;
            for (int j = 0; j < 26; j++) {
                if (count2[j] == 0) continue;

                int[] temp1 = count1.clone();
                int[] temp2 = count2.clone();

                temp1[i]--;
                temp2[i]++;
                temp1[j]++;
                temp2[j]--;

                if (getDistinct(temp1) == getDistinct(temp2)) {
                    return true;
                }
            }
        }

        return false;
    }

    private int getDistinct(int[] count) {
        int distinct = 0;
        for (int num : count) {
            if (num > 0) distinct++;
        }
        return distinct;
    }
}