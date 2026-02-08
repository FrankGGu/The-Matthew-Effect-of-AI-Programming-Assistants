from typing import List

class Solution:
    def decrypt(self, code: List[int], k: int) -> List[int]:
        n = len(code)
        ans = [0] * n

        if k == 0:
            return ans

        if k > 0:
            for i in range(n):
                current_sum = 0
                for j in range(1, k + 1):
                    current_sum += code[(i + j) % n]
                ans[i] = current_sum
        else: # k < 0
            for i in range(n):
                current_sum = 0
                for j in range(1, abs(k) + 1):
                    current_sum += code[(i - j + n) % n]
                ans[i] = current_sum

        return ans