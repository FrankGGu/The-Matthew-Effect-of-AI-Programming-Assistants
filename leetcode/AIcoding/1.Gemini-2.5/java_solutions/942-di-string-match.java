class Solution {
    public int[] diStringMatch(String s) {
        int n = s.length();
        int low = 0;
        int high = n;
        int[] result = new int[n + 1];

        for (int i = 0; i < n; i++) {
            if (s.charAt(i) == 'I') {
                result[i] = low;
                low++;
            } else { // s.charAt(i) == 'D'
                result[i] = high;
                high--;
            }
        }

        result[n] = low; 

        return result;
    }
}