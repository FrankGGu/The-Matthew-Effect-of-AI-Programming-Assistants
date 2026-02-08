public class Solution {
    public long distinctNames(String[] ideas) {
        int[][] count = new int[26][26];
        int[] suffixCount = new int[26];

        for (String idea : ideas) {
            char first = idea.charAt(0);
            String suffix = idea.substring(1);
            int index = first - 'a';
            suffixCount[index]++;
            for (int i = 0; i < 26; i++) {
                if (suffixCount[i] > 0) {
                    count[i][index]++;
                }
            }
        }

        long result = 0;
        for (int i = 0; i < 26; i++) {
            for (int j = i + 1; j < 26; j++) {
                result += (long) count[i][j] * count[j][i];
            }
        }

        return result * 2;
    }
}