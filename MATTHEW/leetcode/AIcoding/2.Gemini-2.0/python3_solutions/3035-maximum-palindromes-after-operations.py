class Solution:
    def maxPalindromesAfterOperations(self, words: list[str]) -> int:
        counts = {}
        for word in words:
            for char in word:
                counts[char] = counts.get(char, 0) + 1

        odds = 0
        for count in counts.values():
            if count % 2 != 0:
                odds += 1

        words.sort(key=len)
        ans = 0
        for word in words:
            if odds <= len(word):
                ans += 1
                odds -= len(word) % 2
                if odds < 0:
                    odds = 0
            else:
                break
        return ans