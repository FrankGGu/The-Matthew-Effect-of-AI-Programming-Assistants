class Solution {
    public List<String> wordSubsets(String[] words1, String[] words2) {
        int[] maxCount = new int[26];
        for (String word : words2) {
            int[] count = countLetters(word);
            for (int i = 0; i < 26; i++) {
                maxCount[i] = Math.max(maxCount[i], count[i]);
            }
        }

        List<String> result = new ArrayList<>();
        for (String word : words1) {
            int[] count = countLetters(word);
            boolean universal = true;
            for (int i = 0; i < 26; i++) {
                if (count[i] < maxCount[i]) {
                    universal = false;
                    break;
                }
            }
            if (universal) {
                result.add(word);
            }
        }
        return result;
    }

    private int[] countLetters(String word) {
        int[] count = new int[26];
        for (char c : word.toCharArray()) {
            count[c - 'a']++;
        }
        return count;
    }
}