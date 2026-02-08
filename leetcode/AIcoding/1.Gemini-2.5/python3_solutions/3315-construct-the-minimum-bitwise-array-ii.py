class Solution:
    def constructBitwiseArray(self, k: int) -> list[int]:
        if k == 0:
            return [0]

        result = []
        for i in range(30): 
            if (k >> i) & 1:
                result.append(1 << i)

        return result