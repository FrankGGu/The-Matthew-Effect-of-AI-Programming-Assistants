class Solution {
    public int maxChoco(int[] chocolates, int K) {
        int n = chocolates.length;
        if (n == 0 || K <= 0) return 0;

        Arrays.sort(chocolates);
        int maxChoco = 0;

        for (int i = n - 1; i >= 0 && K > 0; i--) {
            if (chocolates[i] <= K) {
                maxChoco += chocolates[i];
                K -= chocolates[i];
            } else {
                maxChoco += K;
                break;
            }
        }

        return maxChoco;
    }
}