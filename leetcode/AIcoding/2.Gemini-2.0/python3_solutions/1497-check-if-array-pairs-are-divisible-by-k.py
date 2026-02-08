class Solution:
    def canArrange(self, arr: List[int], k: int) -> bool:
        remainders = [0] * k
        for num in arr:
            remainders[num % k] += 1

        for i in range(1, (k + 1) // 2):
            if remainders[i] != remainders[k - i]:
                return False

        if k % 2 == 0:
            if remainders[k // 2] % 2 != 0:
                return False

        return remainders[0] % 2 == 0