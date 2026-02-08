import java.util.HashSet;
import java.util.Set;

class Solution {
    public int uniqueMorseRepresentations(String[] words) {
        String[] morseCode = {".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."};

        Set<String> uniqueTransformations = new HashSet<>();

        for (String word : words) {
            StringBuilder transformation = new StringBuilder();
            for (char c : word.toCharArray()) {
                transformation.append(morseCode[c - 'a']);
            }
            uniqueTransformations.add(transformation.toString());
        }

        return uniqueTransformations.size();
    }
}