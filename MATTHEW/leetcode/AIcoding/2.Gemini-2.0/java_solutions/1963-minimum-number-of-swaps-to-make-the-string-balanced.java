class Solution {
    public int minSwaps(String s) {
        int open = 0;
        int close = 0;
        for (char c : s.toCharArray()) {
            if (c == '[') {
                open++;
            } else {
                close++;
            }
        }
        int imbalance = 0;
        int countOpen = 0;
        for (char c : s.toCharArray()) {
            if (c == '[') {
                countOpen++;
            } else {
                if (countOpen > 0) {
                    countOpen--;
                } else {
                    imbalance++;
                }
            }
        }
        return (imbalance + 1) / 2;
    }
}