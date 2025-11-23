class Solution {
    public int[] diStringMatch(String s) {
        int n = s.length();
        int low = 0, high = n;
        int[] res = new int[n + 1];
        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == 'I') {
                res[i] = low++;
            } else {
                res[i] = high--;
            }
        }
        res[n] = low;
        return res;
    }
}