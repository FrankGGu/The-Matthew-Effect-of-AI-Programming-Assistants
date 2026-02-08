class Solution {
    public int minFlips(String s) {
        StringBuilder s1 = new StringBuilder();
        StringBuilder s2 = new StringBuilder();
        for (int i = 0; i < s.length(); i++) {
            s1.append(i % 2 == 0 ? '0' : '1');
            s2.append(i % 2 == 0 ? '1' : '0');
        }

        int count1 = 0, count2 = 0;
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) != s1.charAt(i)) count1++;
            if (s.charAt(i) != s2.charAt(i)) count2++;
        }

        int minFlips = Math.min(count1, count2);
        for (int i = 0; i < s.length(); i++) {
            if (s.charAt(i) != s1.charAt(i)) count1--;
            if (s.charAt(i) != s2.charAt(i)) count2--;
            if (i >= s.length() / 2) {
                if (s.charAt(i - s.length() / 2) != s1.charAt(i - s.length() / 2)) count1++;
                if (s.charAt(i - s.length() / 2) != s2.charAt(i - s.length() / 2)) count2++;
            }
            if (i >= s.length() / 2 - 1) {
                minFlips = Math.min(minFlips, Math.min(count1, count2));
            }
        }

        return minFlips;
    }
}