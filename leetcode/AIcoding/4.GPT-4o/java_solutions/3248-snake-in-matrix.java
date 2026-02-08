class Solution {
    public int[] snakeInMatrix(int n) {
        int[] result = new int[n * n];
        int left = 0, right = n - 1, top = 0, bottom = n - 1;
        int index = 0;

        while (left <= right && top <= bottom) {
            for (int i = left; i <= right; i++) {
                result[index++] = top * n + i + 1;
            }
            top++;
            for (int i = top; i <= bottom; i++) {
                result[index++] = i * n + right + 1;
            }
            right--;
            if (top <= bottom) {
                for (int i = right; i >= left; i--) {
                    result[index++] = bottom * n + i + 1;
                }
                bottom--;
            }
            if (left <= right) {
                for (int i = bottom; i >= top; i--) {
                    result[index++] = i * n + left + 1;
                }
                left++;
            }
        }
        return result;
    }
}