class Solution {
    public int[] numMovesStones(int a, int b, int c) {
        int[] arr = {a, b, c};
        Arrays.sort(arr);
        int x = arr[0], y = arr[1], z = arr[2];

        int max = z - x - 2;
        int min;

        if (z - x == 2) {
            min = 0;
        } else if (y - x <= 2 || z - y <= 2) {
            min = 1;
        } else {
            min = 2;
        }

        return new int[]{min, max};
    }
}