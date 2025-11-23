class Solution {
    public boolean halvesAreAlike(String s) {
        Set<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'));
        int count1 = 0, count2 = 0;
        int n = s.length();
        for (int i = 0; i < n / 2; i++) {
            if (vowels.contains(s.charAt(i))) count1++;
        }
        for (int i = n / 2; i < n; i++) {
            if (vowels.contains(s.charAt(i))) count2++;
        }
        return count1 == count2;
    }
}