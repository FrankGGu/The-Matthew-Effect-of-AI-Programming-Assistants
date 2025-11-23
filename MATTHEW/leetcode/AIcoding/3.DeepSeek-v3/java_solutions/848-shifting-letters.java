class Solution {
    public String shiftingLetters(String s, int[] shifts) {
        char[] chars = s.toCharArray();
        int n = shifts.length;
        long totalShift = 0;
        for (int i = n - 1; i >= 0; i--) {
            totalShift += shifts[i];
            int shift = (int)(totalShift % 26);
            chars[i] = (char)((chars[i] - 'a' + shift) % 26 + 'a');
        }
        return new String(chars);
    }
}