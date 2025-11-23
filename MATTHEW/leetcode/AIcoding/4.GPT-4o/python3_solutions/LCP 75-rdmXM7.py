def canReach(nums: List[int], start: int) -> bool:
    n = len(nums)
    visited = set()

    def dfs(index):
        if index < 0 or index >= n or index in visited:
            return False
        if nums[index] == 0:
            return True
        visited.add(index)
        return dfs(index + nums[index]) or dfs(index - nums[index])

    return dfs(start)