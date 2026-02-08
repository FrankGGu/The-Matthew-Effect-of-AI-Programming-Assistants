class Solution {
    public String maxValue(String n, int x) {
        char[] num = n.toCharArray();
        boolean isNegative = num[0] == '-';
        char toInsert = (char) (isNegative ? '0' + x : '0' + x);

        for (int i = (isNegative ? 1 : 0); i < num.length; i++) {
            if ((isNegative && num[i] > toInsert) || (!isNegative && num[i] < toInsert)) {
                return new StringBuilder(n).insert(i, x).toString();
            }
        }
        return n + x;
    }
}