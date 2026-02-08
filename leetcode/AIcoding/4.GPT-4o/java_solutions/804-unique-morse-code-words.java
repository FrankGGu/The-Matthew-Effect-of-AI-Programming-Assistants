import java.util.HashSet;

class Solution {
    public int uniqueMorseRepresentations(String[] words) {
        String[] morseCode = {".-", "-...", "-.-.", "-..", ".", "..-.", "--.", "....", "..", ".---", "-.-", ".-..", "--", "-.", "---", ".--.", "--.-", ".-.", "...", "-", "..-", "...-", ".--", "-..-", "-.--", "--.."};
        HashSet<String> uniqueMorse = new HashSet<>();

        for (String word : words) {
            StringBuilder morseWord = new StringBuilder();
            for (char c : word.toCharArray()) {
                morseWord.append(morseCode[c - 'a']);
            }
            uniqueMorse.add(morseWord.toString());
        }

        return uniqueMorse.size();
    }
}