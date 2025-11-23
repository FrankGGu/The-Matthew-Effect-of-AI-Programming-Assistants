class Solution {
    public int longestStrChain(String[] words) {
        Arrays.sort(words, (a, b) -> a.length() - b.length());
        Map<String, Integer> dp = new HashMap<>();
        int max = 0;
        for (String word : words) {
            int currentMax = 0;
            for (int i = 0; i < word.length(); i++) {
                String predecessor = word.substring(0, i) + word.substring(i + 1);
                currentMax = Math.max(currentMax, dp.getOrDefault(predecessor, 0) + 1);
            }
            dp.put(word, currentMax);
            max = Math.max(max, currentMax);
        }
        return max;
    }
}