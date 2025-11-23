class Solution {
    public int longestDecomposition(String text) {
        int n = text.length();
        int res = 0;
        int left = 0, right = n - 1;
        String l = "", r = "";

        while (left <= right) {
            l = l + text.charAt(left);
            r = text.charAt(right) + r;

            if (l.equals(r)) {
                res += left == right ? 1 : 2;
                l = "";
                r = "";
            }

            left++;
            right--;
        }

        if (!l.isEmpty() || !r.isEmpty()) {
            res++;
        }

        return res;
    }
}