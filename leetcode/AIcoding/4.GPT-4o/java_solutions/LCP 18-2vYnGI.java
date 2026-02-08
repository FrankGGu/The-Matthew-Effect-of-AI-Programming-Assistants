class Solution {
    public int breakfastCombinations(int[] staple, int[] drinks, int x) {
        Arrays.sort(staple);
        Arrays.sort(drinks);
        int count = 0;
        int m = staple.length, n = drinks.length;
        for (int i = 0; i < m; i++) {
            if (staple[i] > x) break;
            int remaining = x - staple[i];
            count += upperBound(drinks, remaining);
            count %= 1000000007;
        }
        return count;
    }

    private int upperBound(int[] arr, int target) {
        int left = 0, right = arr.length;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] <= target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}