class Solution {
    public int minMovesToMakePalindrome(String s) {
        int n = s.length();
        char[] arr = s.toCharArray();
        int moves = 0;
        for (int i = 0; i < n / 2; i++) {
            int j = n - 1 - i;
            while (arr[i] != arr[j]) {
                j--;
            }
            if (i == j) {
                moves += n / 2 - i;
            } else {
                for (int k = j; k < n - 1 - i; k++) {
                    char temp = arr[k];
                    arr[k] = arr[k + 1];
                    arr[k + 1] = temp;
                    moves++;
                }
            }
        }
        return moves;
    }
}