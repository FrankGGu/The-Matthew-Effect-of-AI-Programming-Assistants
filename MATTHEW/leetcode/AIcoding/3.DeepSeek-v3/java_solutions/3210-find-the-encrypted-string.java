class Solution {
    public String encryptString(String s) {
        StringBuilder encrypted = new StringBuilder();
        int n = s.length();
        int left = 0;
        int right = n - 1;
        while (left <= right) {
            if (left == right) {
                encrypted.append(s.charAt(left));
            } else {
                encrypted.append(s.charAt(left));
                encrypted.append(s.charAt(right));
            }
            left++;
            right--;
        }
        return encrypted.toString();
    }
}