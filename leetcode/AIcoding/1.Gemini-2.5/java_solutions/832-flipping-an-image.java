class Solution {
    public int[][] flipAndInvertImage(int[][] image) {
        int n = image.length;
        for (int i = 0; i < n; i++) {
            int left = 0;
            int right = image[i].length - 1;
            while (left <= right) {
                if (left == right) {
                    image[i][left] = 1 - image[i][left];
                } else {
                    int temp = image[i][left];
                    image[i][left] = 1 - image[i][right];
                    image[i][right] = 1 - temp;
                }
                left++;
                right--;
            }
        }
        return image;
    }
}