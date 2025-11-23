class Solution {
    public boolean[] colorTheArray(int n, int[][] queries) {
        boolean[] result = new boolean[queries.length];
        int[] arr = new int[n];
        int coloredCount = 0;

        for (int i = 0; i < queries.length; i++) {
            int index = queries[i][0];
            int color = queries[i][1];

            if (arr[index] != 0) {
                if (index > 0 && arr[index] == arr[index - 1]) coloredCount--;
                if (index < n - 1 && arr[index] == arr[index + 1]) coloredCount--;
            }

            arr[index] = color;

            if (index > 0 && arr[index] == arr[index - 1]) coloredCount++;
            if (index < n - 1 && arr[index] == arr[index + 1]) coloredCount++;

            result[i] = coloredCount > 0;
        }

        return result;
    }
}