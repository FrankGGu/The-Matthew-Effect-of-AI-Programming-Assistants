class Solution {
    public String smallestNumber(String pattern) {
        int n = pattern.length();
        int[] result = new int[n + 1];
        int current = 1;
        for (int i = 0; i <= n; i++) {
            int j = i;
            while (j < n && pattern.charAt(j) == 'I') {
                j++;
            }
            int k = i;
            while (k < n && pattern.charAt(k) == 'D') {
                k++;
            }
            for (int l = k; l >= i; l--) {
                result[l] = current++;
            }
            i = k;
        }
        StringBuilder sb = new StringBuilder();
        for (int num : result) {
            sb.append(num);
        }
        return sb.toString();
    }
}