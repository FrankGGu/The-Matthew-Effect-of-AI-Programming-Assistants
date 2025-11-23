import heapq
import math

class Solution:
    def maximumScore(self, nums: List[int], k: int) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        left = [-1] * n
        right = [n] * n
        stack = []

        for i in range(n):
            while stack and nums[stack[-1]] < nums[i]:
                stack.pop()
            if stack:
                left[i] = stack[-1]
            stack.append(i)

        stack = []
        for i in range(n-1, -1, -1):
            while stack and nums[stack[-1]] <= nums[i]:
                stack.pop()
            if stack:
                right[i] = stack[-1]
            stack.append(i)

        def compute_prime_score(x):
            if x == 1:
                return 0
            res = 0
            for i in range(2, int(math.isqrt(x)) + 1):
                if x % i == 0:
                    res += 1
                    while x % i == 0:
                        x //= i
            if x > 1:
                res += 1
            return res

        prime_scores = [compute_prime_score(num) for num in nums]
        max_heap = []
        for i in range(n):
            cnt = (i - left[i]) * (right[i] - i)
            heapq.heappush(max_heap, (-nums[i], prime_scores[i], cnt))

        res = 1
        while k > 0 and max_heap:
            num, score, cnt = heapq.heappop(max_heap)
            num = -num
            take = min(k, cnt)
            res = (res * pow(num, take, MOD)) % MOD
            k -= take
        return res