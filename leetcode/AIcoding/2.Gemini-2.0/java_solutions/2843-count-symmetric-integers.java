class Solution {
    public int countSymmetricIntegers(int low, int high) {
        int count = 0;
        for (int i = low; i <= high; i++) {
            String s = String.valueOf(i);
            int n = s.length();
            if (n % 2 == 0) {
                int sum1 = 0;
                int sum2 = 0;
                for (int j = 0; j < n / 2; j++) {
                    sum1 += s.charAt(j) - '0';
                }
                for (int j = n / 2; j < n; j++) {
                    sum2 += s.charAt(j) - '0';
                }
                if (sum1 == sum2) {
                    count++;
                }
            }
        }
        return count;
    }
}