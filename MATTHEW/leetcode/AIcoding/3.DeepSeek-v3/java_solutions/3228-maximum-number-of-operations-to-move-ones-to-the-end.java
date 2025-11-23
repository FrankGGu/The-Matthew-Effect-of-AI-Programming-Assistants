class Solution {
    public int minOperations(String s) {
        int count1 = 0; // starts with '1'
        int count2 = 0; // starts with '0'

        for (int i = 0; i < s.length(); i++) {
            char c = s.charAt(i);
            if (i % 2 == 0) {
                if (c == '0') {
                    count1++;
                } else {
                    count2++;
                }
            } else {
                if (c == '1') {
                    count1++;
                } else {
                    count2++;
                }
            }
        }

        return Math.min(count1, count2);
    }
}