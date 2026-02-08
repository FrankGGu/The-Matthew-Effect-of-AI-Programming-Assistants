class Solution:
    def discountPrices(self, sentence: str, discount: int) -> str:
        words = sentence.split()
        result = []
        for word in words:
            if word.startswith('$') and len(word) > 1 and word[1:].isdigit():
                price = int(word[1:])
                discounted_price = price * (100 - discount) / 100
                result.append('${:.2f}'.format(discounted_price))
            else:
                result.append(word)
        return ' '.join(result)