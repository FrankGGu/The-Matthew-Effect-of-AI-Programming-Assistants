class Solution:
    def countPairs(self, words: List[str], target: str) -> int:
        count = 0
        word_count = {}

        for word in words:
            word_count[word] = word_count.get(word, 0) + 1

        for word in words:
            complement = target[len(word):]
            if complement in word_count:
                count += word_count[complement]
                if complement == word:
                    count -= 1

        return count // 2