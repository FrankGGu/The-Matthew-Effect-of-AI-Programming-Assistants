class Solution {
    public int magicalString(int n) {
        if (n == 0) return 0;
        if (n <= 3) return 1;

        int[] s = new int[n + 1];
        s[0] = 1;
        s[1] = 2;
        s[2] = 2;

        int head = 2, tail = 3, num = 1, res = 1;

        while (tail < n) {
            for (int i = 0; i < s[head]; i++) {
                s[tail] = num;
                if (num == 1 && tail < n) res++;
                tail++;
            }
            num ^= 3;
            head++;
        }

        return res;
    }
}