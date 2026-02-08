class Solution {
    public int countSymmetricIntegers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; i++) {
            String numStr = String.valueOf(i);
            int len = numStr.length();
            if (len % 2 == 0) {
                int leftSum = 0, rightSum = 0;
                for (int j = 0; j < len / 2; j++) {
                    leftSum += numStr.charAt(j) - '0';
                    rightSum += numStr.charAt(len - 1 - j) - '0';
                }
                if (leftSum == rightSum) {
                    count++;
                }
            }
        }
        return count;
    }
}