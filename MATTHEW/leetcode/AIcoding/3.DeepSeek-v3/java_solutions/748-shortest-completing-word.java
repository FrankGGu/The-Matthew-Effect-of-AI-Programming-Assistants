class Solution {
    public String shortestCompletingWord(String licensePlate, String[] words) {
        int[] target = count(licensePlate);
        String result = null;
        for (String word : words) {
            if ((result == null || word.length() < result.length()) && dominates(count(word.toLowerCase()), target)) {
                result = word;
            }
        }
        return result;
    }

    private boolean dominates(int[] count1, int[] count2) {
        for (int i = 0; i < 26; i++) {
            if (count1[i] < count2[i]) {
                return false;
            }
        }
        return true;
    }

    private int[] count(String s) {
        int[] result = new int[26];
        for (char c : s.toCharArray()) {
            if (Character.isLetter(c)) {
                result[Character.toLowerCase(c) - 'a']++;
            }
        }
        return result;
    }
}