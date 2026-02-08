public class Solution {
    public boolean areDigitsEqual(String s) {
        int[] count = new int[10];
        for (char c : s.toCharArray()) {
            count[c - '0']++;
        }
        int first = -1;
        for (int i = 0; i < 10; i++) {
            if (count[i] > 0) {
                first = count[i];
                break;
            }
        }
        for (int i = 0; i < 10; i++) {
            if (count[i] > 0 && count[i] != first) {
                return false;
            }
        }
        return true;
    }
}