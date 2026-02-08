class Solution {
    public boolean checkValidString(String s) {
        int leftBalance = 0, starBalance = 0;
        for (char c : s.toCharArray()) {
            if (c == '(') {
                leftBalance++;
            } else if (c == ')') {
                leftBalance--;
            } else {
                starBalance++;
            }
            if (leftBalance < 0) {
                if (starBalance > 0) {
                    starBalance--;
                    leftBalance++;
                } else {
                    return false;
                }
            }
        }
        return leftBalance <= starBalance;
    }
}