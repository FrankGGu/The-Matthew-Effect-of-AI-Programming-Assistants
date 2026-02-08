class Solution {
    public List<Integer> findSubstring(String s, String[] words) {
        List<Integer> result = new ArrayList<>();
        if (s == null || s.length() == 0 || words == null || words.length == 0) {
            return result;
        }
        int wordLength = words[0].length();
        int totalWords = words.length;
        int totalLength = wordLength * totalWords;
        if (s.length() < totalLength) {
            return result;
        }

        Map<String, Integer> wordCount = new HashMap<>();
        for (String word : words) {
            wordCount.put(word, wordCount.getOrDefault(word, 0) + 1);
        }

        for (int i = 0; i <= s.length() - totalLength; i++) {
            String current = s.substring(i, i + totalLength);
            Map<String, Integer> seenWords = new HashMap<>();
            int j = 0;
            while (j < totalLength) {
                String word = current.substring(j, j + wordLength);
                if (!wordCount.containsKey(word)) {
                    break;
                }
                seenWords.put(word, seenWords.getOrDefault(word, 0) + 1);
                if (seenWords.get(word) > wordCount.get(word)) {
                    break;
                }
                j += wordLength;
            }
            if (j == totalLength) {
                result.add(i);
            }
        }
        return result;
    }
}