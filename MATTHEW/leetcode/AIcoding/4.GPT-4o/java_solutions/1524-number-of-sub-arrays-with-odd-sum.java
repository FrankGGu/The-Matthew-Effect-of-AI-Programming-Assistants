class Solution {
    public int numOfSubarrays(int[] arr) {
        int oddCount = 0, evenCount = 1, currentSum = 0, result = 0;

        for (int num : arr) {
            currentSum += num;
            if (currentSum % 2 == 0) {
                result += oddCount;
                evenCount++;
            } else {
                result += evenCount;
                oddCount++;
            }
        }

        return result;
    }
}