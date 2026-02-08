class Solution:
    def minOperations(self, nums: List[int], target: int) -> int:
        nums.sort(reverse=True)
        q = deque(nums)
        ans = 0
        curr_sum = 0

        while curr_sum < target:
            if not q:
                return -1

            curr = q.popleft()
            curr_sum += curr

            if curr_sum > target:
                curr_sum -= curr
                ans += 1
                q.append(curr // 2)
                q.append(curr // 2)
                q = deque(sorted(q, reverse=True))

        return ans