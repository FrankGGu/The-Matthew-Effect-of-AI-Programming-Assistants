class Solution:
    def minimalKSum(self, nums: list[int], k: int) -> int:
        nums = sorted(list(set(nums)))
        ans = 0
        curr = 1
        i = 0
        while k > 0:
            if i < len(nums) and nums[i] == curr:
                curr += 1
                i += 1
                continue

            take = min(k, (nums[i] - curr) if i < len(nums) else k)

            ans += (curr + curr + take - 1) * take // 2

            curr += take
            k -= take

        return ans