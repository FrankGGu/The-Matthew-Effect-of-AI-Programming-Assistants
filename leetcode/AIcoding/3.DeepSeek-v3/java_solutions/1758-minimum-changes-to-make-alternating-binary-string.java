class Solution {
    public int minOperations(String s) {
        int count1 = 0; // starts with '0'
        int count2 = 0; // starts with '1'

        for (int i = 0; i < s.length(); i++) {
            char expectedChar1 = (i % 2 == 0) ? '0' : '1';
            char expectedChar2 = (i % 2 == 0) ? '1' : '0';

            if (s.charAt(i) != expectedChar1) {
                count1++;
            }
            if (s.charAt(i) != expectedChar2) {
                count2++;
            }
        }

        return Math.min(count1, count2);
    }
}