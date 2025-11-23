class Solution:
    def maxConsecutiveChar(self, answer: str, k: int, char_to_maximize: str) -> int:
        n = len(answer)
        left = 0
        max_len = 0
        other_char_count = 0

        for right in range(n):
            if answer[right] != char_to_maximize:
                other_char_count += 1

            while other_char_count > k:
                if answer[left] != char_to_maximize:
                    other_char_count -= 1
                left += 1

            max_len = max(max_len, right - left + 1)

        return max_len

    def maxConsecutiveAnswers(self, answer: str, k: int) -> int:
        return max(self.maxConsecutiveChar(answer, k, 'T'), self.maxConsecutiveChar(answer, k, 'F'))