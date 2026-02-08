public class Solution {
    public int numberOfSubstrings(String s) {
        int count = 0;
        int[] last = new int[2];
        Arrays.fill(last, -1);
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '1') {
                last[1] = i;
            } else {
                last[0] = i;
            }
            count += Math.min(last[0], last[1]) + 1;
        }
        return count;
    }
}