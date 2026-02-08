class Solution {
    public int[] findMissingAndRepeating(int[] arr) {
        int n = arr.length;
        int[] result = new int[2];
        int[] count = new int[n + 1];

        for (int num : arr) {
            count[num]++;
        }

        for (int i = 1; i <= n; i++) {
            if (count[i] == 0) {
                result[0] = i; // Missing number
            }
            if (count[i] == 2) {
                result[1] = i; // Repeating number
            }
        }

        return result;
    }
}