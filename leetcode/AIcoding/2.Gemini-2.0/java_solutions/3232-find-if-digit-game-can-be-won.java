class Solution {
    public boolean digitGame(String n, int x) {
        int len = n.length();
        if (len % 2 == 1) {
            return false;
        }

        int sum = 0;
        for (int i = 0; i < len; i++) {
            sum += n.charAt(i) - '0';
        }

        if (sum >= x) {
            return true;
        }

        return false;
    }
}