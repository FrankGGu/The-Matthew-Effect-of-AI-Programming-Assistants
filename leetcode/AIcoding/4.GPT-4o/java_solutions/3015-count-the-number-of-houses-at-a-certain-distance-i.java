class Solution {
    public int countHouses(int[] houses, int d) {
        Arrays.sort(houses);
        int count = 0;
        for (int i = 0; i < houses.length; i++) {
            int left = houses[i] - d;
            int right = houses[i] + d;
            count += countInRange(houses, left, right);
        }
        return count;
    }

    private int countInRange(int[] houses, int left, int right) {
        int low = Arrays.binarySearch(houses, left);
        if (low < 0) low = -low - 1;
        int high = Arrays.binarySearch(houses, right);
        if (high < 0) high = -high - 1;
        return high - low;
    }
}