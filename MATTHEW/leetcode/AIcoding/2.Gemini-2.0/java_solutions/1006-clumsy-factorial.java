class Solution {
    public int clumsy(int N) {
        if (N == 1) return 1;
        if (N == 2) return 2;
        if (N == 3) return 6;
        if (N == 4) return 7;

        int sum = N * (N - 1) / (N - 2) + (N - 3);

        N -= 4;

        while (N > 0) {
            if (N == 1) {
                sum -= N;
                break;
            }
            if (N == 2) {
                sum -= N * (N - 1);
                break;
            }
            if (N == 3) {
                sum -= N * (N - 1) / (N - 2);
                break;
            }

            sum -= N * (N - 1) / (N - 2);
            sum += (N - 3);
            N -= 4;
        }

        return sum;
    }
}