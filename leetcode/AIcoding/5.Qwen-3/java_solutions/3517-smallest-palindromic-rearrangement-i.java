public class Solution {
    public String primePalindrome(int n) {
        if (n <= 2) return "2";
        if (n <= 3) return "3";
        if (n <= 5) return "5";
        if (n <= 7) return "7";

        for (int len = 1; len <= 5; len++) {
            for (int prefix = 1; prefix < 100000; prefix++) {
                StringBuilder left = new StringBuilder();
                left.append(prefix);
                String right = left.reverse().toString();
                String candidate = left.toString() + right;
                int num = Integer.parseInt(candidate);
                if (num < n) continue;
                if (isPalindrome(num)) {
                    return candidate;
                }
            }
        }
        return "";
    }

    private boolean isPalindrome(int num) {
        String s = String.valueOf(num);
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) return false;
            left++;
            right--;
        }
        return true;
    }
}