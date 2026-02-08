class Solution {
    public int nextGreaterNumericallyBalanced(int n) {
        String s = String.valueOf(n);
        int len = s.length();

        for (int i = len - 1; i > 0; i--) {
            if (s.charAt(i) > s.charAt(i - 1)) {
                int j = len - 1;
                while (s.charAt(j) <= s.charAt(i - 1)) {
                    j--;
                }
                char[] arr = s.toCharArray();
                char temp = arr[i - 1];
                arr[i - 1] = arr[j];
                arr[j] = temp;
                Arrays.sort(arr, i, len);
                long result = Long.parseLong(new String(arr));
                return result <= Integer.MAX_VALUE ? (int) result : -1;
            }
        }
        return -1;
    }
}