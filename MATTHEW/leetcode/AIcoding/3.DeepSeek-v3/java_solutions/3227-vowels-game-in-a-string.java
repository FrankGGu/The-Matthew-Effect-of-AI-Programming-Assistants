class Solution {
    public int countVowelSubstrings(String word) {
        Set<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u'));
        int count = 0;
        for (int i = 0; i < word.length(); i++) {
            Set<Character> currentVowels = new HashSet<>();
            for (int j = i; j < word.length(); j++) {
                char c = word.charAt(j);
                if (!vowels.contains(c)) {
                    break;
                }
                currentVowels.add(c);
                if (currentVowels.size() == 5) {
                    count++;
                }
            }
        }
        return count;
    }
}