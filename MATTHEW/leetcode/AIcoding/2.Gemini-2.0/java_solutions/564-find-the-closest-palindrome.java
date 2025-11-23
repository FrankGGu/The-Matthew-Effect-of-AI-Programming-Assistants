class Solution {
    public String nearestPalindromic(String n) {
        int len = n.length();
        if (len == 1) {
            return String.valueOf(Integer.parseInt(n) - 1);
        }

        long num = Long.parseLong(n);

        long smaller = findSmaller(n);
        long larger = findLarger(n);

        if (Math.abs(num - smaller) <= Math.abs(num - larger)) {
            return String.valueOf(smaller);
        } else {
            return String.valueOf(larger);
        }
    }

    private long findSmaller(String n) {
        int len = n.length();
        if (n.equals("10") || n.equals("100") || n.equals("1000") || n.equals("10000") || n.equals("100000") || n.equals("1000000") || n.equals("10000000") || n.equals("100000000") || n.equals("1000000000") || n.equals("10000000000") || n.equals("100000000000") || n.equals("1000000000000") ){
            return (long)Math.pow(10, len - 1) - 1;
        }
        String prefix = n.substring(0, (len + 1) / 2);
        long prefixNum = Long.parseLong(prefix);

        long candidate1 = createPalindrome(prefixNum, len);
        long candidate2 = createPalindrome(prefixNum - 1, len);

        if (candidate1 >= Long.parseLong(n)) {
            return candidate2;
        } else {
            if (candidate2 < 0) return (long)Math.pow(10, len-1)-1;
            return candidate2;
        }
    }

    private long findLarger(String n) {
        int len = n.length();
        String prefix = n.substring(0, (len + 1) / 2);
        long prefixNum = Long.parseLong(prefix);

        long candidate1 = createPalindrome(prefixNum, len);
        long candidate2 = createPalindrome(prefixNum + 1, len);

        if (candidate1 <= Long.parseLong(n)) {
            return candidate2;
        } else {
            return candidate1;
        }
    }

    private long createPalindrome(long prefix, int len) {
        String prefixStr = String.valueOf(prefix);
        String suffix = new StringBuilder(prefixStr).reverse().toString();
        if (len % 2 == 0) {
            return Long.parseLong(prefixStr + suffix);
        } else {
            return Long.parseLong(prefixStr + suffix.substring(1));
        }
    }
}