class Solution {
    public int countSymmetricIntegers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; i++) {
            String s = String.valueOf(i);
            int len = s.length();

            if (len % 2 != 0) {
                continue;
            }

            int halfLen = len / 2;
            int firstHalfSum = 0;
            int secondHalfSum = 0;

            for (int j = 0; j < halfLen; j++) {
                firstHalfSum += s.charAt(j) - '0';
            }

            for (int j = halfLen; j < len; j++) {
                secondHalfSum += s.charAt(j) - '0';
            }

            if (firstHalfSum == secondHalfSum) {
                count++;
            }
        }
        return count;
    }
}