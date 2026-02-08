class Solution:
    def maximumProduct(self, nums: List[int], k: int) -> int:
        nums.sort()
        mod = 10**9 + 7
        n = len(nums)

        def dfs(index, current_product, current_sum):
            if current_sum == k:
                return current_product
            if index >= n or current_sum > k:
                return -1

            # Include current number
            include = dfs(index + 1, current_product * nums[index] % mod, current_sum + nums[index])
            # Exclude current number
            exclude = dfs(index + 1, current_product, current_sum)

            return max(include, exclude)

        return dfs(0, 1, 0) % mod