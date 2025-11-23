class Solution {
    public int minFlips(String target) {
        int flips = 0;
        char prev = '0';
        for (char c : target.toCharArray()) {
            if (c != prev) {
                flips++;
                prev = c;
            }
        }
        return flips;
    }
}