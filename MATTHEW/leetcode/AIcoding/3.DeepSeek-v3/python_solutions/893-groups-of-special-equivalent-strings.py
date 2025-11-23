class Solution:
    def numSpecialEquivGroups(self, words: List[str]) -> int:
        def get_key(word):
            odd = sorted(word[1::2])
            even = sorted(word[::2])
            return (tuple(odd), tuple(even))

        seen = set()
        for word in words:
            key = get_key(word)
            seen.add(key)
        return len(seen)