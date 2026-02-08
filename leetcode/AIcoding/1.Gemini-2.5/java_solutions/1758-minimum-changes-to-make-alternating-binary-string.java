class Solution {
    public int minOperations(String s) {
        int n = s.length();
        int changesToStartWithZero = 0;
        int changesToStartWithOne = 0;

        for (int i = 0; i < n; i++) {
            char currentChar = s.charAt(i);

            // For string starting with '0' (e.g., "0101...")
            // Even indices should be '0', odd indices should be '1'
            if (i % 2 == 0) { // Expected '0'
                if (currentChar == '1') {
                    changesToStartWithZero++;
                }
            } else { // Expected '1'
                if (currentChar == '0') {
                    changesToStartWithZero++;
                }
            }

            // For string starting with '1' (e.g., "1010...")
            // Even indices should be '1', odd indices should be '0'
            if (i % 2 == 0) { // Expected '1'
                if (currentChar == '0') {
                    changesToStartWithOne++;
                }
            } else { // Expected '0'
                if (currentChar == '1') {
                    changesToStartWithOne++;
                }
            }
        }

        return Math.min(changesToStartWithZero, changesToStartWithOne);
    }
}