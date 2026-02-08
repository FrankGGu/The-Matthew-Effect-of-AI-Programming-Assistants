class Solution {
    public boolean halvesAreAlike(String s) {
        int n = s.length();
        int mid = n / 2;

        String a = s.substring(0, mid);
        String b = s.substring(mid);

        int vowelsA = countVowels(a);
        int vowelsB = countVowels(b);

        return vowelsA == vowelsB;
    }

    private int countVowels(String str) {
        int count = 0;
        String vowels = "aeiouAEIOU";
        for (char c : str.toCharArray()) {
            if (vowels.indexOf(c) != -1) {
                count++;
            }
        }
        return count;
    }
}