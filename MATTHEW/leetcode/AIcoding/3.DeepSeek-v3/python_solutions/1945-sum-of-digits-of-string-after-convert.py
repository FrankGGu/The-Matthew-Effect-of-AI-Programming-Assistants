class Solution:
    def getLucky(self, s: str, k: int) -> int:
        num_str = ''
        for c in s:
            num = ord(c) - ord('a') + 1
            num_str += str(num)

        for _ in range(k):
            total = 0
            for d in num_str:
                total += int(d)
            num_str = str(total)

        return int(num_str)