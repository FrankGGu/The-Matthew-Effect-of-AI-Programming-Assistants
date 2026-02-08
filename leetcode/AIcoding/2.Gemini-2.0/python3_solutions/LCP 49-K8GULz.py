class Solution:
    def canReach(self, nums: List[int], start: int) -> bool:
        n = len(nums)
        visited = [False] * n
        queue = [start]
        visited[start] = True

        while queue:
            curr = queue.pop(0)
            if nums[curr] == 0:
                return True

            next_pos = curr + nums[curr]
            prev_pos = curr - nums[curr]

            if 0 <= next_pos < n and not visited[next_pos]:
                queue.append(next_pos)
                visited[next_pos] = True

            if 0 <= prev_pos < n and not visited[prev_pos]:
                queue.append(prev_pos)
                visited[prev_pos] = True

        return False