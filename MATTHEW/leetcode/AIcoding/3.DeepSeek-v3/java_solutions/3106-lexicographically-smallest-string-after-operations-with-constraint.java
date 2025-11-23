class Solution {
    public String getSmallestString(String s, int k) {
        char[] chars = s.toCharArray();
        for (int i = 0; i < chars.length && k > 0; i++) {
            char current = chars[i];
            char target = 'a';
            int diff1 = (current - target + 26) % 26;
            int diff2 = (target - current + 26) % 26;
            int minDiff = Math.min(diff1, diff2);
            if (minDiff <= k) {
                chars[i] = 'a';
                k -= minDiff;
            } else {
                chars[i] = (char) (current - k);
                k = 0;
            }
        }
        return new String(chars);
    }
}