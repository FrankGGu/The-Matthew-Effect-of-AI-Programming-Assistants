class Solution:
    def maximumNumberOfStringPairs(self, words: List[str]) -> int:
        count = 0
        seen = set()
        for word in words:
            if word in seen:
                continue
            reversed_word = word[::-1]
            if reversed_word in words and reversed_word != word:
                if reversed_word not in seen:
                    count += 1
            seen.add(word)
        return count