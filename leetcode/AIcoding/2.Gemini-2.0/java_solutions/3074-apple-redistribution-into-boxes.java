class Solution {
    public long redistributeApples(int[] boxTypes, int k) {
        long ans = 0;
        Arrays.sort(boxTypes, (a, b) -> b[1] - a[1]);
        for (int[] boxType : boxTypes) {
            int numBoxes = boxType[0];
            int numApples = boxType[1];
            if (numBoxes <= k) {
                ans += (long) numBoxes * numApples;
                k -= numBoxes;
            } else {
                ans += (long) k * numApples;
                break;
            }
        }
        return ans;
    }
}