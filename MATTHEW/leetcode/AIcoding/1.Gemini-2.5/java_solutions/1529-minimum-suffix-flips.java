class Solution {
    public int minFlips(String target) {
        int flips = 0;
        char currentFlipState = '0';

        for (char c : target.toCharArray()) {
            if (c != currentFlipState) {
                flips++;
                currentFlipState = (currentFlipState == '0' ? '1' : '0');
            }
        }

        return flips;
    }
}