class Solution {
    public String toGoatLatin(String sentence) {
        String[] words = sentence.split(" ");
        StringBuilder result = new StringBuilder();
        Set<Character> vowels = new HashSet<>(Arrays.asList('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U'));

        for (int i = 0; i < words.length; i++) {
            String word = words[i];
            StringBuilder transformed = new StringBuilder();

            if (vowels.contains(word.charAt(0))) {
                transformed.append(word);
            } else {
                transformed.append(word.substring(1));
                transformed.append(word.charAt(0));
            }

            transformed.append("ma");
            for (int j = 0; j <= i; j++) {
                transformed.append("a");
            }

            if (i != words.length - 1) {
                transformed.append(" ");
            }
            result.append(transformed.toString());
        }

        return result.toString();
    }
}