class Solution {
    public int maxPalindromesAfterOperations(String[] words) {
        int[] freq = new int[26];
        for (String word : words) {
            for (char c : word.toCharArray()) {
                freq[c - 'a']++;
            }
        }

        int pairs = 0;
        for (int count : freq) {
            pairs += count / 2;
        }

        Arrays.sort(words, (a, b) -> a.length() - b.length());
        int res = 0;
        for (String word : words) {
            int requiredPairs = word.length() / 2;
            if (pairs >= requiredPairs) {
                pairs -= requiredPairs;
                res++;
            } else {
                break;
            }
        }
        return res;
    }
}