class Solution:
    def maxConsecutiveAnswers(self, answerKey: str, k: int) -> int:
        def max_consecutive(char):
            l = 0
            count = 0
            max_len = 0
            for r in range(len(answerKey)):
                if answerKey[r] != char:
                    count += 1
                while count > k:
                    if answerKey[l] != char:
                        count -= 1
                    l += 1
                max_len = max(max_len, r - l + 1)
            return max_len

        return max(max_consecutive('T'), max_consecutive('F'))