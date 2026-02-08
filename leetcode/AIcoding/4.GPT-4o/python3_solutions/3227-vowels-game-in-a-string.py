class Solution:
    def vowelsGame(self, s: str) -> str:
        vowels = set('aeiouAEIOU')
        alice_score = sum(1 for char in s if char in vowels and s.index(char) % 2 == 0)
        bob_score = sum(1 for char in s if char in vowels and s.index(char) % 2 != 0)

        if alice_score > bob_score:
            return "Alice"
        elif bob_score > alice_score:
            return "Bob"
        else:
            return "Draw"