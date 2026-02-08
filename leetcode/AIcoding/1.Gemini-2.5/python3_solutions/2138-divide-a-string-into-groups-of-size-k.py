class Solution:
    def divideString(self, s: str, k: int, fill: str) -> list[str]:
        n = len(s)
        remainder = n % k

        if remainder != 0:
            padding_needed = k - remainder
            s += fill * padding_needed

        result = []
        for i in range(0, len(s), k):
            result.append(s[i : i + k])

        return result