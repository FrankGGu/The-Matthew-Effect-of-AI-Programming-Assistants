from collections import defaultdict

class Solution:
    def subarraysWithKDistinct(self, A: List[int], K: int) -> int:
        def atMostK(K):
            count = defaultdict(int)
            res = left = 0
            for right in range(len(A)):
                if count[A[right]] == 0:
                    K -= 1
                count[A[right]] += 1

                while K < 0:
                    count[A[left]] -= 1
                    if count[A[left]] == 0:
                        K += 1
                    left += 1

                res += right - left + 1
            return res

        return atMostK(K) - atMostK(K - 1)