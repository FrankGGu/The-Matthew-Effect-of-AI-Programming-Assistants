class Solution {
    public int[] diStringMatch(String S) {
        int n = S.length();
        int[] result = new int[n + 1];
        int low = 0, high = n;
        for (int i = 0; i < n; i++) {
            if (S.charAt(i) == 'I') {
                result[i] = low++;
            } else {
                result[i] = high--;
            }
        }
        result[n] = low;
        return result;
    }
}