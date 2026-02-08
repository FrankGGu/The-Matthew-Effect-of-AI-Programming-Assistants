class Solution:
    def totalCharacters(self, words: list[str]) -> int:
        def transform(s: str) -> str:
            d = {}
            res = ""
            count = 0
            for c in s:
                if c not in d:
                    d[c] = count
                    count += 1
                res += str(d[c])
            return res

        transformed_words = [transform(word) for word in words]
        return sum(len(word) for word in transformed_words)