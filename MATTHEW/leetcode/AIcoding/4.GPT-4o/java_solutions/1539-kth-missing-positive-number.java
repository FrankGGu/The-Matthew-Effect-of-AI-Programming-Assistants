class Solution {
    public int findKthPositive(int[] arr, int k) {
        int missingCount = 0, currentIndex = 1, arrIndex = 0;
        while (missingCount < k) {
            if (arrIndex < arr.length && arr[arrIndex] == currentIndex) {
                arrIndex++;
            } else {
                missingCount++;
            }
            currentIndex++;
        }
        return currentIndex - 1;
    }
}