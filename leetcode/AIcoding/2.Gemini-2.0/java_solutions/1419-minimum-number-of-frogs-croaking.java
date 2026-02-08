class Solution {
    public int minNumberOfFrogs(String croakOfFrogs) {
        int c = 0, r = 0, o = 0, a = 0, k = 0;
        int frogs = 0, maxFrogs = 0;

        for (char ch : croakOfFrogs.toCharArray()) {
            if (ch == 'c') {
                c++;
                frogs++;
                maxFrogs = Math.max(maxFrogs, frogs);
            } else if (ch == 'r') {
                r++;
                c--;
            } else if (ch == 'o') {
                o++;
                r--;
            } else if (ch == 'a') {
                a++;
                o--;
            } else if (ch == 'k') {
                k++;
                a--;
                frogs--;
            }

            if (c < 0 || r < 0 || o < 0 || a < 0 || k < 0) {
                return -1;
            }
        }

        if (c != 0 || r != 0 || o != 0 || a != 0 || k != 0) {
            return -1;
        }

        return maxFrogs;
    }
}