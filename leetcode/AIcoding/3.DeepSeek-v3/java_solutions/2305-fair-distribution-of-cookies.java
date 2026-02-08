class Solution {
    private int res = Integer.MAX_VALUE;

    public int distributeCookies(int[] cookies, int k) {
        int[] children = new int[k];
        backtrack(cookies, children, 0);
        return res;
    }

    private void backtrack(int[] cookies, int[] children, int index) {
        if (index == cookies.length) {
            int max = 0;
            for (int c : children) {
                max = Math.max(max, c);
            }
            res = Math.min(res, max);
            return;
        }

        for (int i = 0; i < children.length; i++) {
            children[i] += cookies[index];
            backtrack(cookies, children, index + 1);
            children[i] -= cookies[index];
        }
    }
}