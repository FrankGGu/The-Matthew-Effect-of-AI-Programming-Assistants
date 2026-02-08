class Solution:
    def hashDividedString(self, s: str, k: int) -> bool:
        n = len(s)

        if k <= 0:
            return False

        if n == 0:
            return False

        if n % k != 0:
            return False

        segment_len = n // k

        first_segment = s[0:segment_len]

        for i in range(1, k):
            current_segment = s[i * segment_len : (i + 1) * segment_len]
            if current_segment != first_segment:
                return False

        return True