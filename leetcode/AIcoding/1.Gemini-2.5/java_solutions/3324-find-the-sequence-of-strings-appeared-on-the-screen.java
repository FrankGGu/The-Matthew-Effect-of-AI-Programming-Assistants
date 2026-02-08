import java.util.*;

class Solution {
    public List<String> longestChain(String[] words) {
        Arrays.sort(words, (a, b) -> a.length() - b.length());

        Map<String, Integer> dp = new HashMap<>();
        Map<String, String> predecessor = new HashMap<>();

        int maxChainLength = 0;
        String lastWordInLongestChain = "";

        for (String word : words) {
            dp.put(word, 1);
            predecessor.put(word, null);

            for (int i = 0; i < word.length(); i++) {
                StringBuilder sb = new StringBuilder(word);
                String prevWord = sb.deleteCharAt(i).toString();

                if (dp.containsKey(prevWord)) {
                    if (dp.get(prevWord) + 1 > dp.get(word)) {
                        dp.put(word, dp.get(prevWord) + 1);
                        predecessor.put(word, prevWord);
                    }
                }
            }

            if (dp.get(word) > maxChainLength) {
                maxChainLength = dp.get(word);
                lastWordInLongestChain = word;
            }
        }

        List<String> longestChain = new ArrayList<>();
        String current = lastWordInLongestChain;
        while (current != null) {
            longestChain.add(0, current);
            current = predecessor.get(current);
        }

        return longestChain;
    }
}