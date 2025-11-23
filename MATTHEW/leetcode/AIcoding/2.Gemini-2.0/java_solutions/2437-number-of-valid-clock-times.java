class Solution {
    public int countTime(String time) {
        int h = 1, m = 1;
        if (time.charAt(0) == '?') {
            if (time.charAt(1) == '?') {
                h = 24;
            } else {
                if (time.charAt(1) <= '3') {
                    h = 3;
                } else {
                    h = 2;
                }
            }
        } else {
            if (time.charAt(1) == '?') {
                if (time.charAt(0) == '0' || time.charAt(0) == '1') {
                    h = 10;
                } else {
                    h = 4;
                }
            }
        }
        if (time.charAt(3) == '?') {
            if (time.charAt(4) == '?') {
                m = 60;
            } else {
                m = 6;
            }
        } else {
            if (time.charAt(4) == '?') {
                m = 10;
            }
        }
        return h * m;
    }
}