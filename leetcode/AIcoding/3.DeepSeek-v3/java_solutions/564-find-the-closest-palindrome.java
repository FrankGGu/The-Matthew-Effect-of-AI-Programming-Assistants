class Solution {
    public String nearestPalindromic(String n) {
        long num = Long.parseLong(n);
        if (num == 1) return "0";

        String candidate1 = getPalindrome(n);
        long diff1 = Math.abs(num - Long.parseLong(candidate1));
        diff1 = diff1 == 0 ? Long.MAX_VALUE : diff1;

        StringBuilder s = new StringBuilder(n);
        int i = (s.length() - 1) / 2;
        while (i >= 0 && s.charAt(i) == '0') {
            s.setCharAt(i, '9');
            i--;
        }
        if (i == 0 && s.charAt(i) == '1') {
            s.delete(0, 1);
            int mid = (s.length() - 1) / 2;
            s.setCharAt(mid, '9');
        } else {
            s.setCharAt(i, (char)(s.charAt(i) - 1));
        }
        String candidate2 = getPalindrome(s.toString());
        long diff2 = Math.abs(num - Long.parseLong(candidate2));

        s = new StringBuilder(n);
        i = (s.length() - 1) / 2;
        while (i >= 0 && s.charAt(i) == '9') {
            s.setCharAt(i, '0');
            i--;
        }
        if (i < 0) {
            s.insert(0, '1');
        } else {
            s.setCharAt(i, (char)(s.charAt(i) + 1));
        }
        String candidate3 = getPalindrome(s.toString());
        long diff3 = Math.abs(num - Long.parseLong(candidate3));

        if (diff2 <= diff1 && diff2 <= diff3) {
            return candidate2;
        } else if (diff1 <= diff3 && diff1 <= diff2) {
            return candidate1;
        } else {
            return candidate3;
        }
    }

    private String getPalindrome(String num) {
        char[] arr = num.toCharArray();
        int i = 0;
        int j = arr.length - 1;
        while (i < j) {
            arr[j] = arr[i];
            i++;
            j--;
        }
        return new String(arr);
    }
}