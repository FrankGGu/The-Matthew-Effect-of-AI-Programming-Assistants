class Solution {
    public int[] fullBloomFlowers(int[][] flowers, int[] people) {
        int n = flowers.length;
        int[] starts = new int[n];
        int[] ends = new int[n];

        for (int i = 0; i < n; i++) {
            starts[i] = flowers[i][0];
            ends[i] = flowers[i][1] + 1;
        }

        Arrays.sort(starts);
        Arrays.sort(ends);

        int[] res = new int[people.length];
        for (int i = 0; i < people.length; i++) {
            int time = people[i];
            int left = binarySearch(starts, time);
            int right = binarySearch(ends, time);
            res[i] = left - right;
        }
        return res;
    }

    private int binarySearch(int[] arr, int target) {
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