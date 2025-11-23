class Solution {
    public int totalCharacters(String[] words) {
        int[] totalCount = new int[26];
        for (String word : words) {
            for (char c : word.toCharArray()) {
                totalCount[c - 'a']++;
            }
        }
        int max = 0;
        for (int count : totalCount) {
            max = Math.max(max, count);
        }
        return max;
    }
}