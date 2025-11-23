class Solution:
    def findKthCharacter(self, n: int, k: int) -> str:
        current_n = n
        current_k = k

        while current_n > 0:
            mid_idx = 1 << current_n

            if current_k == mid_idx:
                return chr(ord('a') + current_n)
            elif current_k < mid_idx:
                current_n -= 1
            else:
                current_k -= mid_idx
                current_n -= 1

        return 'a'