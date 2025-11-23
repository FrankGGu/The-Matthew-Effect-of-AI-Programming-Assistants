class Solution:
    def uniqueMorseRepresentations(self, words: list[str]) -> int:
        morse_codes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.","---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]

        unique_transformations = set()

        for word in words:
            current_transformation = []
            for char in word:
                index = ord(char) - ord('a')
                current_transformation.append(morse_codes[index])
            unique_transformations.add("".join(current_transformation))

        return len(unique_transformations)