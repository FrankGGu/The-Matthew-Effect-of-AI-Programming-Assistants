class Solution {
    public boolean canWin(String current) {
        for (int i = 0; i < current.length() - 1; i++) {
            if (current.charAt(i) == '+' && current.charAt(i + 1) == '+') {
                String next = current.substring(0, i) + "--" + current.substring(i + 2);
                if (!canWin(next)) {
                    return true;
                }
            }
        }
        return false;
    }
}