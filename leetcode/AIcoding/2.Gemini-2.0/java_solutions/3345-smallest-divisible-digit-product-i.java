class Solution {
    public int smallestNumber(int n) {
        if (n == 0) return 0;
        if (n == 1) return 1;
        StringBuilder sb = new StringBuilder();
        for (int i = 9; i >= 2; i--) {
            while (n % i == 0) {
                n /= i;
                sb.append(i);
            }
        }
        if (n != 1) return -1;
        return Integer.parseInt(sb.reverse().toString());
    }
}