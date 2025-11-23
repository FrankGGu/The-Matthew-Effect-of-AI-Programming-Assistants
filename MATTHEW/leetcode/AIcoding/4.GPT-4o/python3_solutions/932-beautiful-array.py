class Solution:
    def beautifulArray(self, N: int) -> List[int]:
        if N == 1:
            return [1]
        odds = self.beautifulArray((N + 1) // 2)
        evens = self.beautifulArray(N // 2)
        return [x * 2 - 1 for x in odds] + [x * 2 for x in evens]