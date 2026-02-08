class Solution {
    public String strWithout3a3b(int A, int B) {
        StringBuilder result = new StringBuilder();
        while (A > 0 || B > 0) {
            if (A > B) {
                if (A > 0) {
                    result.append('a');
                    A--;
                }
                if (A > 0) {
                    result.append('a');
                    A--;
                }
                if (B > 0) {
                    result.append('b');
                    B--;
                }
            } else {
                if (B > 0) {
                    result.append('b');
                    B--;
                }
                if (B > 0) {
                    result.append('b');
                    B--;
                }
                if (A > 0) {
                    result.append('a');
                    A--;
                }
            }
        }
        return result.toString();
    }
}