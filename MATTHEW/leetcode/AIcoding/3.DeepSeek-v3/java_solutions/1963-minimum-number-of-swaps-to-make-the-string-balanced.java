class Solution {
    public int minSwaps(String s) {
        int balance = 0;
        int swaps = 0;
        int j = s.length() - 1;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) == '[') {
                balance++;
            } else {
                balance--;
            }
            if (balance < 0) {
                while (i < j && s.charAt(j) != '[') {
                    j--;
                }
                if (i >= j) break;
                swaps++;
                balance += 2;
                j--;
            }
        }
        return swaps;
    }
}