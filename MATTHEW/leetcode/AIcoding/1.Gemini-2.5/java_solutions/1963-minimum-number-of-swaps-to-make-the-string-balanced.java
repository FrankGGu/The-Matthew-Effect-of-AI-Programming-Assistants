class Solution {
    public int minSwaps(String s) {
        int balance = 0;
        int extraClose = 0;

        for (char c : s.toCharArray()) {
            if (c == '[') {
                balance++;
            } else { // c == ']'
                if (balance > 0) {
                    balance--;
                } else {
                    extraClose++;
                }
            }
        }

        return (extraClose + 1) / 2;
    }
}