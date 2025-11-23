import java.util.*;

class Solution {
    public List<List<Integer>> palindromePairs(String[] words) {
        Map<String, Integer> wordMap = new HashMap<>();
        for (int i = 0; i < words.length; i++) {
            wordMap.put(words[i], i);
        }

        Set<List<Integer>> uniqueResults = new HashSet<>();

        for (int i = 0; i < words.length; i++) {
            String word = words[i];

            for (int k = 0; k <= word.length(); k++) {
                String prefix = word.substring(0, k);
                String suffix = word.substring(k);

                // Case 1: `s2 + word` forms a palindrome.
                // `word = P + S`, where `P` is a palindrome and `s2 = reverse(S)`.
                // We are looking for `words[j] = reverse(suffix)`.
                // Then `words[j] + words[i]` is `reverse(suffix) + prefix + suffix`.
                // If `prefix` is a palindrome, this forms a palindrome.
                if (isPalindrome(prefix)) {
                    String reversedSuffix = new StringBuilder(suffix).reverse().toString();
                    if (wordMap.containsKey(reversedSuffix)) {
                        int j = wordMap.get(reversedSuffix);
                        if (i != j) { // Ensure distinct indices
                            uniqueResults.add(Arrays.asList(j, i));
                        }
                    }
                }

                // Case 2: `word + s2` forms a palindrome.
                // `word = P + S`, where `S` is a palindrome and `s2 = reverse(P)`.
                // We are looking for `words[j] = reverse(prefix)`.
                // Then `words[i] + words[j]` is `prefix + suffix + reverse(prefix)`.
                // If `suffix` is a palindrome, this forms a palindrome.
                // The condition `k > 0` is crucial to avoid duplicate pairs that arise from `prefix` being empty.
                // When `k=0`, `prefix` is empty, `reversedPrefix` is empty. This would check `word + ""`.
                // This scenario is already implicitly covered by Case 1 when `k=word.length()` (i.e., `suffix` is empty).
                // Example: `word="a"`, `i=0`. `empty_string_idx=1`.
                // Case 1, `k=1`: `prefix="a"`, `suffix=""`. `isPalindrome("a")` true. `reversedSuffix=""`. `j=1`. Add `(1,0)`.
                // Case 2, `k=0`: `prefix=""`, `suffix="a"`. `isPalindrome("a")` true. `reversedPrefix=""`. `j=1`. Add `(0,1)`.
                // These are distinct and correctly added. The `k > 0` condition is not strictly necessary for correctness with a `HashSet`,
                // but it can prune some redundant checks. However, removing it makes the logic more symmetrical and handles all cases.
                // The `HashSet` handles duplicates effectively.
                if (isPalindrome(suffix)) {
                    String reversedPrefix = new StringBuilder(prefix).reverse().toString();
                    if (wordMap.containsKey(reversedPrefix)) {
                        int j = wordMap.get(reversedPrefix);
                        if (i != j) { // Ensure distinct indices
                            uniqueResults.add(Arrays.asList(i, j));
                        }
                    }
                }
            }
        }

        return new ArrayList<>(uniqueResults);
    }

    private boolean isPalindrome(String s) {
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }
}