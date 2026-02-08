class Solution:
    def discountPrices(self, sentence: str, discount: int) -> str:
        words = sentence.split()
        discount_factor = (100 - discount) / 100
        for i in range(len(words)):
            if words[i][0] == '$' and words[i][1:].isdigit():
                original_price = int(words[i][1:])
                new_price = original_price * discount_factor
                words[i] = f"${new_price:.2f}"
        return ' '.join(words)