class Solution {
    public int minimumCost(int[] horizontalCuts, int[] verticalCuts) {
        Arrays.sort(horizontalCuts);
        Arrays.sort(verticalCuts);

        int maxH = Math.max(horizontalCuts[0], horizontalCuts.length > 0 ? horizontalCuts[horizontalCuts.length - 1] : 0);
        int prev = 0;
        for (int cut : horizontalCuts) {
            maxH = Math.max(maxH, cut - prev);
            prev = cut;
        }
        maxH = Math.max(maxH, horizontalCuts.length > 0 ? 100000 - horizontalCuts[horizontalCuts.length - 1] : 100000);

        int maxV = Math.max(verticalCuts[0], verticalCuts.length > 0 ? verticalCuts[verticalCuts.length - 1] : 0);
        prev = 0;
        for (int cut : verticalCuts) {
            maxV = Math.max(maxV, cut - prev);
            prev = cut;
        }
        maxV = Math.max(maxV, verticalCuts.length > 0 ? 100000 - verticalCuts[verticalCuts.length - 1] : 100000);

        return (int) ((long) maxH * maxV % 1000000007);
    }
}