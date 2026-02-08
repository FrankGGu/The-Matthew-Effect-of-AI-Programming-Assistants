class Solution {
    public int cutBamboo(int[] bamboo) {
        if (bamboo == null || bamboo.length == 0) {
            return 0;
        }

        int n = bamboo.length;
        int minHeight = Integer.MAX_VALUE;
        int minHeightCount = 0;

        for (int height : bamboo) {
            if (height < minHeight) {
                minHeight = height;
                minHeightCount = 1;
            } else if (height == minHeight) {
                minHeightCount++;
            }
        }

        return n - minHeightCount;
    }
}