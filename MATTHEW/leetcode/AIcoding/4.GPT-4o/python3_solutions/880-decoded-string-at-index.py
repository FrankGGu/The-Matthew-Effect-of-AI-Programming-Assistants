class Solution:
    def decodeAtIndex(self, S: str, K: int) -> str:
        length = 0
        for char in S:
            if char.isdigit():
                length *= int(char)
            else:
                length += 1

        for i in range(len(S) - 1, -1, -1):
            K %= length
            if K == 0 and S[i].isalpha():
                return S[i]
            if S[i].isdigit():
                length //= int(S[i])
            else:
                length -= 1