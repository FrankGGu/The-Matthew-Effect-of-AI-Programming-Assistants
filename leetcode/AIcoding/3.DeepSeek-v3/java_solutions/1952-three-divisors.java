class Solution {
    public boolean isThree(int n) {
        if (n < 4) return false;
        int sqrt = (int) Math.sqrt(n);
        if (sqrt * sqrt != n) return false;
        for (int i = 2; i * i <= sqrt; i++) {
            if (sqrt % i == 0) return false;
        }
        return true;
    }
}