class Solution {
    public int minCharacters(String a, String b) {
        int[] countA = new int[26];
        int[] countB = new int[26];
        int n = a.length(), m = b.length();

        for (char c : a.toCharArray()) countA[c - 'a']++;
        for (char c : b.toCharArray()) countB[c - 'a']++;

        int minChange = Integer.MAX_VALUE;

        for (int i = 0; i < 26; i++) {
            int totalA = 0, totalB = 0;
            for (int j = 0; j < 26; j++) {
                if (j < i) {
                    totalA += countA[j];
                    totalB += countB[j];
                }
            }
            minChange = Math.min(minChange, totalA + totalB);
        }

        for (int i = 0; i < 26; i++) {
            minChange = Math.min(minChange, n - countA[i] + m - countB[i]);
        }

        return minChange;
    }
}