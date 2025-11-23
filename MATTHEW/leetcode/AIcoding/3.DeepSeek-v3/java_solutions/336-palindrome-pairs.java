import java.util.*;

class Solution {
    public List<List<Integer>> palindromePairs(String[] words) {
        List<List<Integer>> res = new ArrayList<>();
        if (words == null || words.length < 2) return res;
        Map<String, Integer> map = new HashMap<>();
        for (int i = 0; i < words.length; i++) {
            map.put(words[i], i);
        }

        for (int i = 0; i < words.length; i++) {
            for (int j = 0; j <= words[i].length(); j++) {
                String str1 = words[i].substring(0, j);
                String str2 = words[i].substring(j);
                if (isPalindrome(str1)) {
                    String str2rev = new StringBuilder(str2).reverse().toString();
                    if (map.containsKey(str2rev) && map.get(str2rev) != i) {
                        res.add(Arrays.asList(map.get(str2rev), i));
                    }
                }
                if (isPalindrome(str2) && str2.length() != 0) {
                    String str1rev = new StringBuilder(str1).reverse().toString();
                    if (map.containsKey(str1rev) && map.get(str1rev) != i) {
                        res.add(Arrays.asList(i, map.get(str1rev)));
                    }
                }
            }
        }
        return res;
    }

    private boolean isPalindrome(String s) {
        int left = 0;
        int right = s.length() - 1;
        while (left <= right) {
            if (s.charAt(left++) != s.charAt(right--)) {
                return false;
            }
        }
        return true;
    }
}