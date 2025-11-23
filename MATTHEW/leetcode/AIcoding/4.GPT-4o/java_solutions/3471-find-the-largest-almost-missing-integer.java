class Solution {
    public int findLargestInteger(String s, int k) {
        int n = s.length();
        int[] count = new int[10];
        for (char c : s.toCharArray()) {
            count[c - '0']++;
        }

        for (int i = 9; i >= 0; i--) {
            if (count[i] > 0) {
                if (count[i] > k) {
                    return i; 
                } else {
                    k -= count[i];
                }
            }
        }
        return -1;
    }
}