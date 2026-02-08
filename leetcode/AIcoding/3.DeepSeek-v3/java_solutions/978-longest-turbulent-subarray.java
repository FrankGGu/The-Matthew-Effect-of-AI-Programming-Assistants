class Solution {
    public int maxTurbulenceSize(int[] arr) {
        if (arr.length == 1) {
            return 1;
        }
        int maxLen = 1;
        int currentLen = 1;
        int prevSign = 0;

        for (int i = 1; i < arr.length; i++) {
            int currSign = Integer.compare(arr[i], arr[i - 1]);
            if (currSign == 0) {
                currentLen = 1;
                prevSign = 0;
            } else if (prevSign * currSign < 0) {
                currentLen++;
                prevSign = currSign;
            } else {
                currentLen = 2;
                prevSign = currSign;
            }
            maxLen = Math.max(maxLen, currentLen);
        }
        return maxLen;
    }
}