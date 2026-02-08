class Solution:
    def areSentencesSimilar(self, sentence1: str, sentence2: str) -> bool:
        words1 = sentence1.split()
        words2 = sentence2.split()

        n1 = len(words1)
        n2 = len(words2)

        # Ensure words1 is always the longer or equal length sentence
        if n1 < n2:
            words1, words2 = words2, words1
            n1, n2 = n2, n1

        left1 = 0
        right1 = n1 - 1

        left2 = 0
        right2 = n2 - 1

        # Match from the left
        while left2 <= right2 and words1[left1] == words2[left2]:
            left1 += 1
            left2 += 1

        # Match from the right
        while left2 <= right2 and words1[right1] == words2[right2]:
            right1 -= 1
            right2 -= 1

        # If all words in words2 have been matched (either from left or right),
        # then left2 would have passed right2.
        return left2 > right2