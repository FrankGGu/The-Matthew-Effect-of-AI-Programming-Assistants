public class Solution {
    public int longestAwesome(String s) {
        int[] count = new int[10];
        int result = 0;
        int mask = 0;
        int[] firstIndex = new int[1024];
        for (int i = 0; i < 1024; i++) {
            firstIndex[i] = -1;
        }
        firstIndex[0] = -1;
        for (int i = 0; i < s.length(); i++) {
            int digit = s.charAt(i) - '0';
            count[digit]++;
            if (count[digit] % 2 == 1) {
                mask ^= (1 << digit);
            } else {
                mask ^= (1 << digit);
            }
            if (firstIndex[mask] == -1) {
                firstIndex[mask] = i;
            } else {
                result = Math.max(result, i - firstIndex[mask]);
            }
        }
        return result;
    }
}