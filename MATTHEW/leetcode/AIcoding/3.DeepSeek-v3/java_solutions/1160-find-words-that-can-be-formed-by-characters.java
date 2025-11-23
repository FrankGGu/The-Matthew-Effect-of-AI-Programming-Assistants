class Solution {
    public int countCharacters(String[] words, String chars) {
        int[] charCount = new int[26];
        for (char c : chars.toCharArray()) {
            charCount[c - 'a']++;
        }

        int result = 0;
        for (String word : words) {
            int[] tempCount = charCount.clone();
            boolean valid = true;
            for (char c : word.toCharArray()) {
                if (tempCount[c - 'a']-- <= 0) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                result += word.length();
            }
        }
        return result;
    }
}