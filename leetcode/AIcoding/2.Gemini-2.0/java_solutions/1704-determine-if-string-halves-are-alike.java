class Solution {
    public boolean halvesAreAlike(String s) {
        int n = s.length();
        int mid = n / 2;
        String a = s.substring(0, mid);
        String b = s.substring(mid);
        int countA = 0;
        int countB = 0;
        String vowels = "aeiouAEIOU";
        for (char c : a.toCharArray()) {
            if (vowels.indexOf(c) != -1) {
                countA++;
            }
        }
        for (char c : b.toCharArray()) {
            if (vowels.indexOf(c) != -1) {
                countB++;
            }
        }
        return countA == countB;
    }
}