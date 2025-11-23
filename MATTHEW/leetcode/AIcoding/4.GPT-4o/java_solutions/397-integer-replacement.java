class Solution {
    public int integerReplacement(int n) {
        long num = n;
        int steps = 0;
        while (num > 1) {
            if ((num & 1) == 0) {
                num >>= 1;
            } else {
                if (num == 3 || ((num >>> 1) & 1) == 0) {
                    num--;
                } else {
                    num++;
                }
            }
            steps++;
        }
        return steps;
    }
}