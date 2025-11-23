class Solution {
    public boolean isFascinating(int n) {
        String num = String.valueOf(n);
        String combined = num + (n * 2) + (n * 3);
        int[] count = new int[10];

        for (char c : combined.toCharArray()) {
            count[c - '0']++;
        }

        return count[0] == 0 && count[1] == 1 && count[2] == 1 && count[3] == 1 && 
               count[4] == 1 && count[5] == 1 && count[6] == 1 && count[7] == 1 && 
               count[8] == 1 && count[9] == 1;
    }
}