class Solution {
    public String decodeAtIndex(String S, int K) {
        long length = 0;
        for (char c : S.toCharArray()) {
            if (Character.isDigit(c)) {
                length *= (c - '0');
            } else {
                length++;
            }
        }

        for (int i = S.length() - 1; i >= 0; i--) {
            char c = S.charAt(i);
            K %= length;
            if (K == 0 && Character.isLetter(c)) {
                return String.valueOf(c);
            }
            if (Character.isDigit(c)) {
                length /= (c - '0');
            } else {
                length--;
            }
        }
        return "";
    }
}