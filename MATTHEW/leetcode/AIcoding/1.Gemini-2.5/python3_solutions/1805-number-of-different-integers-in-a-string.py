import re

class Solution:
    def numDifferentIntegers(self, word: str) -> int:
        numbers = re.findall(r'\d+', word)
        unique_integers = set()
        for num_str in numbers:
            unique_integers.add(str(int(num_str)))
        return len(unique_integers)