import java.util.HashMap;
import java.util.Map;

class Solution {
    public int longestPalindrome(String[] words) {
        Map<String, Integer> freq = new HashMap<>();
        for (String w : words) {
            freq.put(w, freq.getOrDefault(w, 0) + 1);
        }

        int ans = 0;
        boolean hasOddPalindrome = false;

        for (String word : freq.keySet()) {
            if (freq.get(word) == 0) {
                continue;
            }

            String rev_word = new StringBuilder(word).reverse().toString();

            if (word.equals(rev_word)) {
                int count = freq.get(word);
                ans += (count / 2) * 2 * word.length();

                if (count % 2 == 1) {
                    hasOddPalindrome = true;
                }
                freq.put(word, 0);
            } else {
                if (freq.containsKey(rev_word) && freq.get(rev_word) > 0) {
                    int count1 = freq.get(word);
                    int count2 = freq.get(rev_word);

                    int pairs = Math.min(count1, count2);

                    ans += pairs * 2 * word.length();

                    freq.put(word, freq.get(word) - pairs);
                    freq.put(rev_word, freq.get(rev_word) - pairs);
                }
            }
        }

        if (hasOddPalindrome) {
            ans += 2;
        }

        return ans;
    }
}