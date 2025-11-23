class Solution {
    public int[] replaceElements(int[] arr) {
        int n = arr.length;
        if (n == 0) {
            return arr;
        }

        int maxSoFar = -1;

        for (int i = n - 1; i >= 0; i--) {
            int currentElement = arr[i];
            arr[i] = maxSoFar;
            if (currentElement > maxSoFar) {
                maxSoFar = currentElement;
            }
        }

        return arr;
    }
}