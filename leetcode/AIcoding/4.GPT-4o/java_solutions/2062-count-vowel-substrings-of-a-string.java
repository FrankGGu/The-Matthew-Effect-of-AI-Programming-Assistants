class Solution {
    public int countVowelSubstrings(String word) {
        int count = 0;
        int n = word.length();
        Set<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));

        for (int i = 0; i < n; i++) {
            Set<Character> seen = new HashSet<>();
            for (int j = i; j < n; j++) {
                char c = word.charAt(j);
                if (!vowels.contains(c)) break;
                seen.add(c);
                if (seen.size() == 5) {
                    count++;
                }
            }
        }
        return count;
    }
}