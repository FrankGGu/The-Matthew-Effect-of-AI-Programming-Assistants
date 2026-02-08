class Solution {
    public int countTime(String time) {
        char h1 = time.charAt(0);
        char h2 = time.charAt(1);
        char m1 = time.charAt(3);
        char m2 = time.charAt(4);

        int countH = 1;
        if (h1 == '?' && h2 == '?') {
            countH = 24;
        } else if (h1 == '?') {
            if (h2 < '4') {
                countH = 3;
            } else {
                countH = 2;
            }
        } else if (h2 == '?') {
            if (h1 == '2') {
                countH = 4;
            } else {
                countH = 10;
            }
        }

        int countM = 1;
        if (m1 == '?' && m2 == '?') {
            countM = 60;
        } else if (m1 == '?') {
            countM = 6;
        } else if (m2 == '?') {
            countM = 10;
        }

        return countH * countM;
    }
}