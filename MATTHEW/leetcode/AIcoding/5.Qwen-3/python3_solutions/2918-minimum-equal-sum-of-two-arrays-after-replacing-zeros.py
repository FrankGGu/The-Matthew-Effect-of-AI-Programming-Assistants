class Solution:
    def minEqualSum(self, a: List[int], b: List[int]) -> int:
        from collections import deque

        def get_min_sum(arr):
            q = deque()
            for num in arr:
                if num == 0:
                    q.append(0)
                else:
                    while q and num > q[0]:
                        q.popleft()
                    if not q or num < q[0]:
                        q.append(num)
            return sum(q)

        sum_a = get_min_sum(a)
        sum_b = get_min_sum(b)

        return max(sum_a, sum_b)