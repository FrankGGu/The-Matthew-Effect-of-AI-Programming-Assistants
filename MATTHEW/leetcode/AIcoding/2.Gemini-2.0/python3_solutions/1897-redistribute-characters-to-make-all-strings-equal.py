class Solution:
    def makeEqual(self, words: List[str]) -> bool:
        count = {}
        for word in words:
            for char in word:
                count[char] = count.get(char, 0) + 1

        n = len(words)
        for char_count in count.values():
            if char_count % n != 0:
                return False

        return True