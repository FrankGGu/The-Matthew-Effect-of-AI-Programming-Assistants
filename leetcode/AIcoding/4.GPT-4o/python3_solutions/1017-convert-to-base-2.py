class Solution:
    def baseNeg2(self, N: int) -> str:
        if N == 0:
            return "0"

        res = []
        while N != 0:
            N, remainder = divmod(N, -2)
            if remainder < 0:
                N += 1
                remainder += 2
            res.append(str(remainder))

        return ''.join(res[::-1])