class Solution {
    public int longestEvenOdd(int[] arr, int threshold) {
        int maxLength = 0;
        int currentLength = 0;
        boolean isEven = arr[0] % 2 == 0;

        for (int num : arr) {
            if (num <= threshold) {
                if ((num % 2 == 0) == isEven) {
                    currentLength++;
                } else {
                    maxLength = Math.max(maxLength, currentLength);
                    currentLength = 1;
                    isEven = !isEven;
                }
            } else {
                maxLength = Math.max(maxLength, currentLength);
                currentLength = 0;
            }
        }

        return Math.max(maxLength, currentLength);
    }
}