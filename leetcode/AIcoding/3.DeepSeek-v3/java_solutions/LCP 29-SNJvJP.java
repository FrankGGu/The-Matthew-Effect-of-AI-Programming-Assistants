class Solution {
    public int orchestraLayout(int num, int xPos, int yPos) {
        long layer = Math.min(Math.min(xPos, yPos), Math.min(num - 1 - xPos, num - 1 - yPos));
        long start = 4 * layer * (num - layer);
        long sideLength = num - 2 * layer;

        if (xPos == layer) {
            long offset = yPos - layer + 1;
            return (int)((start + offset - 1) % 9 + 1);
        } else if (yPos == num - 1 - layer) {
            long offset = xPos - layer + 1;
            return (int)((start + sideLength - 1 + offset - 1) % 9 + 1);
        } else if (xPos == num - 1 - layer) {
            long offset = num - layer - 1 - yPos;
            return (int)((start + 2 * (sideLength - 1) + offset) % 9 + 1);
        } else {
            long offset = num - layer - 1 - xPos;
            return (int)((start + 3 * (sideLength - 1) + offset) % 9 + 1);
        }
    }
}