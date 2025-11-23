class Solution {
    public String maxValue(String n, int x) {
        StringBuilder sb = new StringBuilder(n);
        boolean isNegative = n.charAt(0) == '-';
        int insertPos = 0;

        if (isNegative) {
            insertPos = 1;
            while (insertPos < sb.length() && (sb.charAt(insertPos) - '0' <= x)) {
                insertPos++;
            }
        } else {
            while (insertPos < sb.length() && (sb.charAt(insertPos) - '0' >= x)) {
                insertPos++;
            }
        }

        sb.insert(insertPos, x);
        return sb.toString();
    }
}