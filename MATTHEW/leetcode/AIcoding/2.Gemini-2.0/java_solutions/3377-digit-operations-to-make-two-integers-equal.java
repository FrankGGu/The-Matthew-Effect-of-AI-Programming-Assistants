class Solution {
    public int minimumOperations(int num1, int num2) {
        if (num1 == num2) return 0;
        String s1 = String.valueOf(num1);
        String s2 = String.valueOf(num2);
        int n1 = s1.length();
        int n2 = s2.length();
        int diff = Math.abs(n1 - n2);
        int ans = diff;
        int i = 0, j = 0;
        if (n1 > n2) {
            i = diff;
        } else {
            j = diff;
        }
        while (i < n1 && j < n2) {
            if (s1.charAt(i) != s2.charAt(j)) {
                ans++;
            }
            i++;
            j++;
        }
        return ans;
    }
}