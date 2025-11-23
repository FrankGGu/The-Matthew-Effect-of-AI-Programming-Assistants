class Solution:
    def minimumDivisionOperations(self, nums: list[int], divisors: list[int]) -> int:
        n = len(nums)
        m = len(divisors)

        q = [(nums, 0)]
        visited = {tuple(nums)}

        while q:
            curr_nums, steps = q.pop(0)

            if all(curr_nums[i] <= curr_nums[i+1] for i in range(n-1)):
                return steps

            for i in range(n):
                for j in range(m):
                    new_nums = curr_nums[:]
                    new_nums[i] //= divisors[j]

                    new_tuple = tuple(new_nums)

                    if new_tuple not in visited:
                        q.append((new_nums, steps + 1))
                        visited.add(new_tuple)

        return -1