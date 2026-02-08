class Solution {
    public int maxHeightOfTriangle(int red, int blue) {
        return Math.max(calculateHeight(red, blue), calculateHeight(blue, red));
    }

    private int calculateHeight(int count1, int count2) {
        int h = 0;
        int currentRowLength = 1;
        boolean useCount1 = true;

        while (true) {
            if (useCount1) {
                if (count1 >= currentRowLength) {
                    count1 -= currentRowLength;
                    h++;
                } else {
                    break;
                }
            } else {
                if (count2 >= currentRowLength) {
                    count2 -= currentRowLength;
                    h++;
                } else {
                    break;
                }
            }
            currentRowLength++;
            useCount1 = !useCount1;
        }
        return h;
    }
}