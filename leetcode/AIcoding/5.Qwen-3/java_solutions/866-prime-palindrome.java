public class PrimePalindrome {
    public int primePalindrome(int n) {
        if (n <= 2) return 2;
        if (n <= 3) return 3;
        if (n <= 5) return 5;
        if (n <= 7) return 7;

        for (int i = 11; ; i += 2) {
            if (isPalindrome(i) && isPrime(i)) {
                return i;
            }
        }
    }

    private boolean isPalindrome(int x) {
        String s = Integer.toString(x);
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    private boolean isPrime(int x) {
        if (x % 2 == 0) return false;
        int sqrtX = (int) Math.sqrt(x);
        for (int i = 3; i <= sqrtX; i += 2) {
            if (x % i == 0) return false;
        }
        return true;
    }
}