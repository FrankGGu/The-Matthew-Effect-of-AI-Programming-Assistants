class Solution:
    def game(self, guess: List[int], answer: List[int]) -> int:
        count = 0
        for g, a in zip(guess, answer):
            if g == a:
                count += 1
        return count