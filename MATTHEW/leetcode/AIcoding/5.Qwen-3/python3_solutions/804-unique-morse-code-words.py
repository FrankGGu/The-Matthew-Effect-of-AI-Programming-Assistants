class Solution:
    def uniqueMorseRepresentations(self, words):
        morse_codes = [".-","-...","-.-.","-..",".","..-.","--.","....","..",".---","-.-",".-..","--","-.",
                        "---",".--.","--.-",".-.","...","-","..-","...-",".--","-..-","-.--","--.."]
        letters = 'abcdefghijklmnopqrstuvwxyz'
        code_map = {letter: code for letter, code in zip(letters, morse_codes)}
        seen = set()
        for word in words:
            code = ''.join(code_map[letter] for letter in word)
            seen.add(code)
        return len(seen)