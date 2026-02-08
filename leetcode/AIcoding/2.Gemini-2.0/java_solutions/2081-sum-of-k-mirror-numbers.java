class Solution {
    public long kMirror(int k, int n) {
        long sum = 0;
        int count = 0;
        long num = 1;
        while (count < n) {
            long base = (long) Math.pow(10, String.valueOf(num).length() - 1);
            long palindrome = createPalindrome(num);
            if (isPalindrome(Long.toString(palindrome, k))) {
                sum += palindrome;
                count++;
            }
            num++;
            if (num > base * 10) {
                num = (long) Math.pow(10, String.valueOf(num).length() / 2);
            }
        }
        return sum;
    }

    private long createPalindrome(long num) {
        String s = String.valueOf(num);
        String reversed = new StringBuilder(s).reverse().toString();
        return Long.parseLong(s + reversed);
    }

    private boolean isPalindrome(String s) {
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
}