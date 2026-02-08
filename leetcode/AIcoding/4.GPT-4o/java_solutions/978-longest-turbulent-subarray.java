class Solution {
    public int maxTurbulenceSize(int[] arr) {
        if (arr.length < 2) return arr.length;
        int maxLength = 1, currentLength = 1;
        for (int i = 1; i < arr.length; i++) {
            if ((arr[i] > arr[i - 1] && (i == 1 || arr[i - 1] <= arr[i - 2])) || 
                (arr[i] < arr[i - 1] && (i == 1 || arr[i - 1] >= arr[i - 2]))) {
                currentLength++;
            } else {
                currentLength = 2;
            }
            maxLength = Math.max(maxLength, currentLength);
        }
        return maxLength;
    }
}