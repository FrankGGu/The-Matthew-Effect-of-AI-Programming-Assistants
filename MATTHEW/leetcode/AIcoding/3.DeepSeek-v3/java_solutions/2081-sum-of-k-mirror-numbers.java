class Solution {
    public long kMirror(int k, int n) {
        long sum = 0;
        int count = 0;
        long num = 1;
        while (count < n) {
            if (isMirror(num) && isMirrorInBase(num, k)) {
                sum += num;
                count++;
            }
            num++;
        }
        return sum;
    }

    private boolean isMirror(long num) {
        String s = Long.toString(num);
        int left = 0, right = s.length() - 1;
        while (left < right) {
            if (s.charAt(left) != s.charAt(right)) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    }

    private boolean isMirrorInBase(long num, int base) {
        StringBuilder sb = new StringBuilder();
        while (num > 0) {
            sb.append(num % base);
            num /= base;
        }
        String s = sb.toString();
        int left = 0, right = s.length() - 1;
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