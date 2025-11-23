import java.util.HashSet;

public class Solution {
    public String longestDupSubstring(String s) {
        int n = s.length(), left = 1, right = n - 1;
        String result = "";

        while (left <= right) {
            int mid = left + (right - left) / 2;
            String temp = search(s, mid);
            if (!temp.isEmpty()) {
                result = temp;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        return result;
    }

    private String search(String s, int length) {
        HashSet<String> seen = new HashSet<>();
        String substring = s.substring(0, length);
        seen.add(substring);
        long hash = hash(substring);
        long base = 1;

        for (int i = 1; i < length; i++) {
            base = (base * 256) % 1000000007;
        }

        for (int start = 1; start <= s.length() - length; start++) {
            hash = (hash * 256 - s.charAt(start - 1) * base + s.charAt(start + length - 1)) % 1000000007;
            if (hash < 0) hash += 1000000007;
            substring = s.substring(start, start + length);
            if (seen.contains(substring)) return substring;
            seen.add(substring);
        }
        return "";
    }

    private long hash(String s) {
        long h = 0;
        for (char c : s.toCharArray()) {
            h = (h * 256 + c) % 1000000007;
        }
        return h;
    }
}