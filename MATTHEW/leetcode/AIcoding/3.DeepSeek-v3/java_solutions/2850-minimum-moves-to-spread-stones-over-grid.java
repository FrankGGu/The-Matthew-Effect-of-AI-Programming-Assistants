class Solution {
    public int minimumMoves(int[][] grid) {
        List<int[]> stones = new ArrayList<>();
        List<int[]> holes = new ArrayList<>();

        for (int i = 0; i < 3; i++) {
            for (int j = 0; j < 3; j++) {
                if (grid[i][j] > 1) {
                    for (int k = 0; k < grid[i][j] - 1; k++) {
                        stones.add(new int[]{i, j});
                    }
                } else if (grid[i][j] == 0) {
                    holes.add(new int[]{i, j});
                }
            }
        }

        int minMoves = Integer.MAX_VALUE;
        int[] perm = new int[stones.size()];
        for (int i = 0; i < perm.length; i++) {
            perm[i] = i;
        }

        do {
            int total = 0;
            for (int i = 0; i < perm.length; i++) {
                int[] stone = stones.get(i);
                int[] hole = holes.get(perm[i]);
                total += Math.abs(stone[0] - hole[0]) + Math.abs(stone[1] - hole[1]);
            }
            minMoves = Math.min(minMoves, total);
        } while (nextPermutation(perm));

        return minMoves;
    }

    private boolean nextPermutation(int[] array) {
        int i = array.length - 2;
        while (i >= 0 && array[i] >= array[i + 1]) {
            i--;
        }
        if (i < 0) {
            return false;
        }

        int j = array.length - 1;
        while (array[j] <= array[i]) {
            j--;
        }

        swap(array, i, j);
        reverse(array, i + 1, array.length - 1);
        return true;
    }

    private void swap(int[] array, int i, int j) {
        int temp = array[i];
        array[i] = array[j];
        array[j] = temp;
    }

    private void reverse(int[] array, int start, int end) {
        while (start < end) {
            swap(array, start, end);
            start++;
            end--;
        }
    }
}