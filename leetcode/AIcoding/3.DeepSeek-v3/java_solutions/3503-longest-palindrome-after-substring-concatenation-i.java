class Solution {
    public int longestPalindrome(String s, String[] words) {
        Map<String, Integer> count = new HashMap<>();
        for (String word : words) {
            count.put(word, count.getOrDefault(word, 0) + 1);
        }

        int res = 0;
        boolean central = false;

        for (Map.Entry<String, Integer> entry : count.entrySet()) {
            String word = entry.getKey();
            int wordCount = entry.getValue();
            if (word.charAt(0) == word.charAt(1)) {
                if (wordCount % 2 == 0) {
                    res += wordCount;
                } else {
                    res += wordCount - 1;
                    central = true;
                }
            } else {
                String reversed = new StringBuilder(word).reverse().toString();
                if (count.containsKey(reversed)) {
                    int reversedCount = count.get(reversed);
                    res += Math.min(wordCount, reversedCount);
                }
            }
        }

        if (central) {
            res += 1;
        }

        return res * 2;
    }
}