public class Solution {
    public int clumsy(int N) {
        if (N == 1) return 1;
        if (N == 2) return 2;
        if (N == 3) return 6;
        int result = N;
        int i = 1;
        while (i < N) {
            if (i % 4 == 1) {
                result -= (i + 1);
            } else if (i % 4 == 2) {
                result *= (i + 1);
            } else if (i % 4 == 3) {
                result /= (i + 1);
            }
            i++;
        }
        return result;
    }
}