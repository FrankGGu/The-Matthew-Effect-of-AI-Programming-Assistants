class Solution:
    def maxTotalFruits(self, fruits: List[List[int]], startPos: int, k: int) -> int:
        left = 0
        right = 0
        n = len(fruits)
        res = 0
        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + fruits[i][1]

        def get_left_bound(pos):
            l, r = 0, n
            while l < r:
                mid = (l + r) // 2
                if fruits[mid][0] < pos:
                    l = mid + 1
                else:
                    r = mid
            return l

        left_bound = get_left_bound(startPos - k)
        right_bound = get_left_bound(startPos + k + 1)

        for i in range(left_bound, right_bound):
            l = get_left_bound(2 * fruits[i][0] + k - startPos)
            r = get_left_bound(startPos + k + 1)
            res = max(res, prefix_sum[min(r, right_bound)] - prefix_sum[max(l, left_bound)])

        for i in range(left_bound, right_bound):
            l = get_left_bound(startPos - k)
            r = get_left_bound(2 * fruits[i][0] - k - startPos)
            res = max(res, prefix_sum[min(r, right_bound)] - prefix_sum[max(l, left_bound)])

        return res