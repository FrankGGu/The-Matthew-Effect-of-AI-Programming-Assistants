class Solution {
    public int distributeCandies(int[] candyType) {
        int uniqueTypes = (int) Arrays.stream(candyType).distinct().count();
        int maxCandies = candyType.length / 2;
        return Math.min(uniqueTypes, maxCandies);
    }
}