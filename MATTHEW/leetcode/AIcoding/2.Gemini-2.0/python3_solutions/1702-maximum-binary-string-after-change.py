class Solution:
    def maximumBinaryString(self, binary: str) -> str:
        n = len(binary)
        zeros = 0
        first_zero = -1
        for i in range(n):
            if binary[i] == '0':
                zeros += 1
                if first_zero == -1:
                    first_zero = i
        if zeros == 0:
            return binary

        ans = ['1'] * n
        ans[first_zero + zeros - 1] = '0'
        return "".join(ans)