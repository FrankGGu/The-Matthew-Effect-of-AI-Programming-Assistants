class Solution:
    def discountPrices(self, sentence: str) -> str:
        words = sentence.split()
        for i in range(len(words)):
            if words[i][0] == '$' and words[i][1:].isdigit():
                price = int(words[i][1:])
                if (i + 1) % 3 == 0:
                    discounted = price * 0.9
                    words[i] = f"${discounted:.2f}"
        return ' '.join(words)