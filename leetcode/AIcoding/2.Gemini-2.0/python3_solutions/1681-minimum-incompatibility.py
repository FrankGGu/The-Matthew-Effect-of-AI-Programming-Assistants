from collections import defaultdict

class Solution:
    def minimumIncompatibility(self, nums: list[int], k: int) -> int:
        n = len(nums)
        group_size = n // k
        nums.sort()

        subsets = []
        def find_subsets(index, current_subset, used):
            if len(current_subset) == group_size:
                subsets.append(current_subset[:])
                return

            if index == n:
                return

            if used[index]:
                find_subsets(index + 1, current_subset, used)
                return

            current_subset.append(nums[index])
            used[index] = True
            find_subsets(index + 1, current_subset, used)
            current_subset.pop()
            used[index] = False
            find_subsets(index + 1, current_subset, used)

        used = [False] * n
        find_subsets(0, [], used)

        valid_subsets = []
        for subset in subsets:
            if len(set(subset)) == group_size:
                valid_subsets.append(subset)

        memo = {}
        def solve(mask):
            if mask == (1 << n) - 1:
                return 0

            if mask in memo:
                return memo[mask]

            min_incompatibility = float('inf')
            for subset in valid_subsets:
                subset_mask = 0
                valid = True
                for num in subset:
                    index = nums.index(num)
                    temp_index = 0
                    count = 0
                    for i in range(n):
                        if nums[i] == num:
                            if count == temp_index:
                                index = i
                                break
                            temp_index += 1

                    if (mask >> index) & 1:
                        valid = False
                        break
                    subset_mask |= (1 << index)

                if valid:
                    incompatibility = max(subset) - min(subset)
                    min_incompatibility = min(min_incompatibility, incompatibility + solve(mask | subset_mask))

            memo[mask] = min_incompatibility
            return min_incompatibility

        result = solve(0)
        if result == float('inf'):
            return -1
        else:
            return result