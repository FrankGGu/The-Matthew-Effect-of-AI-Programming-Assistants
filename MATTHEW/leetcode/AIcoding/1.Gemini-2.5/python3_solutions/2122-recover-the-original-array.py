import collections

class Solution:
    def recoverArray(self, nums: list[int]) -> list[int]:
        nums.sort()
        n = len(nums) // 2

        for j in range(1, 2 * n):
            k_candidate = nums[j] - nums[0]

            if k_candidate <= 0 or k_candidate % 2 != 0:
                continue

            current_arr = []
            counts = collections.Counter(nums)
            is_valid_k = True

            for num_val in nums:
                if counts[num_val] == 0:
                    continue

                if counts[num_val + k_candidate] > 0:
                    current_arr.append(num_val)
                    counts[num_val] -= 1
                    counts[num_val + k_candidate] -= 1
                else:
                    is_valid_k = False
                    break

            if is_valid_k and len(current_arr) == n:
                return current_arr