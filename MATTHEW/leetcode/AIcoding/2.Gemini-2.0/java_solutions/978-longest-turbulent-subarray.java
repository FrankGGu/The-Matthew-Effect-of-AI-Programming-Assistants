class Solution {
    public int maxTurbulenceSize(int[] arr) {
        int n = arr.length;
        if (n < 2) {
            return n;
        }
        int maxLen = 1;
        int left = 0;
        int right = 0;

        while (right < n - 1) {
            if (left == right) {
                if (arr[left] == arr[left + 1]) {
                    left++;
                }
                right++;
            } else {
                if ((arr[right - 1] < arr[right] && arr[right] > arr[right + 1]) ||
                    (arr[right - 1] > arr[right] && arr[right] < arr[right + 1])) {
                    right++;
                } else {
                    left = right;
                }
            }
            maxLen = Math.max(maxLen, right - left + 1);
        }

        return maxLen;
    }
}