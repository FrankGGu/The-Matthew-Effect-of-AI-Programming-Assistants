class Solution:
    def discountPrices(self, sentence: str, discount: int) -> str:
        words = sentence.split()
        result_words = []
        for word in words:
            if word.startswith('$') and len(word) > 1 and word[1:].isdigit():
                price = float(word[1:])
                discounted_price = price * (1 - discount / 100)
                result_words.append(f"${discounted_price:.2f}")
            else:
                result_words.append(word)
        return " ".join(result_words)