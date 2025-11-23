class Solution {
    public int minFlips(String target) {
        int flips = 0;
        char current = '0';
        for (char c : target.toCharArray()) {
            if (c != current) {
                flips++;
                current = c;
            }
        }
        return flips;
    }
}