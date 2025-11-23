class Solution {
    public int maximumSwap(int num) {
        char[] digits = String.valueOf(num).toCharArray();
        int n = digits.length;

        int[] maxIndices = new int[n];
        maxIndices[n - 1] = n - 1;

        for (int i = n - 2; i >= 0; i--) {
            if (digits[i] > digits[maxIndices[i + 1]]) {
                maxIndices[i] = i;
            } else {
                maxIndices[i] = maxIndices[i + 1];
            }
        }

        for (int i = 0; i < n; i++) {
            int maxIdxInSuffix = maxIndices[i];
            if (digits[maxIdxInSuffix] > digits[i]) {
                char temp = digits[i];
                digits[i] = digits[maxIdxInSuffix];
                digits[maxIdxInSuffix] = temp;

                return Integer.parseInt(new String(digits));
            }
        }

        return num;
    }
}