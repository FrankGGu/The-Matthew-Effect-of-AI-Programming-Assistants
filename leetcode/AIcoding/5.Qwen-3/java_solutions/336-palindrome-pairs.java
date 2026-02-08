public class Solution {

import java.util.*;

public class Solution {
    public List<List<Integer>> palindromePairs(int[] words) {
        List<List<Integer>> result = new ArrayList<>();
        Map<String, Integer> wordToIndex = new HashMap<>();
        for (int i = 0; i < words.length; i++) {
            wordToIndex.put(words[i], i);
        }

        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            for (int j = 0; j <= word.length(); j++) {
                String prefix = word.substring(0, j);
                String suffix = word.substring(j);
                if (isPalindrome(prefix)) {
                    int reverseSuffixIndex = wordToIndex.getOrDefault(new StringBuilder(suffix).reverse().toString(), -1);
                    if (reverseSuffixIndex != -1 && reverseSuffixIndex != i) {
                        result.add(Arrays.asList(reverseSuffixIndex, i));
                    }
                }
                if (isPalindrome(suffix)) {
                    int reversePrefixIndex = wordToIndex.getOrDefault(new StringBuilder(prefix).reverse().toString(), -1);
                    if (reversePrefixIndex != -1 && reversePrefixIndex != i) {
                        result.add(Arrays.asList(i, reversePrefixIndex));
                    }
                }
            }
        }

        return result;
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
}