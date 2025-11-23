class Solution {
    private int minUnfairness = Integer.MAX_VALUE;

    public int distributeCookies(int[] cookies, int k) {
        int[] distribution = new int[k];
        distribute(cookies, 0, distribution);
        return minUnfairness;
    }

    private void distribute(int[] cookies, int index, int[] distribution) {
        if (index == cookies.length) {
            int max = 0;
            for (int value : distribution) {
                max = Math.max(max, value);
            }
            minUnfairness = Math.min(minUnfairness, max);
            return;
        }

        for (int i = 0; i < distribution.length; i++) {
            distribution[i] += cookies[index];
            distribute(cookies, index + 1, distribution);
            distribution[i] -= cookies[index];
        }
    }
}