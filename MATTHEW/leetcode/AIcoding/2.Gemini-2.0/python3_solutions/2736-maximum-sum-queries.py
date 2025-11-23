class Solution:
    def maximumSumQueries(self, nums1: List[int], nums2: List[int], queries: List[List[int]]) -> List[int]:
        n = len(nums1)
        arr = sorted(zip(nums1, nums2), reverse=True)
        m = len(queries)
        queries_with_idx = sorted([(x, y, i) for i, (x, y) in enumerate(queries)], reverse=True)

        result = [-1] * m

        stack = []

        j = 0
        for x, y, i in queries_with_idx:
            while j < n and arr[j][0] >= x:
                num1, num2 = arr[j]
                while stack and stack[-1][1] <= num2:
                    stack.pop()
                if not stack:
                    stack.append((num2, num1 + num2))
                else:
                    stack.append((num2, num1 + num2))
                j += 1

            l, r = 0, len(stack) - 1
            ans = -1
            while l <= r:
                mid = (l + r) // 2
                if stack[mid][0] >= y:
                    ans = stack[mid][1]
                    r = mid - 1
                else:
                    l = mid + 1
            result[i] = ans

        return result