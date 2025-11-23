public class Solution {
    public int minSuffixFlips(String[] power) {
        int flips = 0;
        for (int i = 0; i < power.length; i++) {
            if (power[i].equals("0")) {
                flips++;
            }
        }
        return flips;
    }
}