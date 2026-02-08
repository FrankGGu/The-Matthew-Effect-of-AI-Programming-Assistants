public class Solution {

import java.util.*;

public class Solution {
    public String longestSubsequenceRepeatedK(char[] s, int k) {
        List<Character> candidates = new ArrayList<>();
        Set<Character> freq = new HashSet<>();
        for (char c : s) {
            freq.add(c);
        }
        for (char c : freq) {
            candidates.add(c);
        }
        Collections.sort(candidates);
        int n = s.length;
        StringBuilder result = new StringBuilder();
        for (int len = candidates.size(); len >= 1; len--) {
            List<String> list = new ArrayList<>();
            generate(candidates, len, 0, new StringBuilder(), list);
            for (String seq : list) {
                if (check(s, seq, k)) {
                    return seq;
                }
            }
        }
        return "";
    }

    private void generate(List<Character> candidates, int len, int start, StringBuilder current, List<String> result) {
        if (current.length() == len) {
            result.add(current.toString());
            return;
        }
        for (int i = start; i < candidates.size(); i++) {
            current.append(candidates.get(i));
            generate(candidates, len, i + 1, current, result);
            current.deleteCharAt(current.length() - 1);
        }
    }

    private boolean check(char[] s, String seq, int k) {
        int count = 0;
        int index = 0;
        for (char c : s) {
            if (c == seq.charAt(index)) {
                index++;
                if (index == seq.length()) {
                    count++;
                    index = 0;
                }
            }
        }
        return count >= k;
    }
}
}