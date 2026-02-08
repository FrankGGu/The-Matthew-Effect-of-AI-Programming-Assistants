class Solution {
    public String robotWithString(String s) {
        StringBuilder res = new StringBuilder();
        StringBuilder t = new StringBuilder();
        int[] freq = new int[26];
        for (char c : s.toCharArray()) {
            freq[c - 'a']++;
        }
        int min = 0;
        for (char c : s.toCharArray()) {
            freq[c - 'a']--;
            while (min < 26 && freq[min] == 0) {
                min++;
            }
            t.append(c);
            while (t.length() > 0 && (t.charAt(t.length() - 1) - 'a' <= min) {
                res.append(t.charAt(t.length() - 1));
                t.deleteCharAt(t.length() - 1);
            }
        }
        return res.toString();
    }
}