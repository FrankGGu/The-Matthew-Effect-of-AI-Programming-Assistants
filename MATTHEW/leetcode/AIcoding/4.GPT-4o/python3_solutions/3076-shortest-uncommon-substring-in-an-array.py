class Solution:
    def shortestUncommonSubstring(self, words: List[str]) -> str:
        def is_uncommon(sub: str) -> bool:
            return all(sub not in word for word in words)

        min_length = float('inf')
        result = ""

        for word in words:
            for length in range(1, len(word) + 1):
                for start in range(len(word) - length + 1):
                    substring = word[start:start + length]
                    if is_uncommon(substring):
                        if len(substring) < min_length:
                            min_length = len(substring)
                            result = substring
                        break
                if min_length < float('inf'):
                    break
            if min_length < float('inf'):
                break

        return result