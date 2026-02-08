class Solution:
    def readBinaryWatch(self, turnedOn: int) -> List[str]:
        def count_bits(n):
            return bin(n).count('1')

        res = []
        for h in range(12):
            for m in range(60):
                if count_bits(h) + count_bits(m) == turnedOn:
                    res.append(f"{h}:{m:02d}")
        return res