class Solution:
    def waysToPartition(self, nums: List[int], k: int) -> int:
        prefix = [0] * len(nums)
        prefix[0] = nums[0]
        for i in range(1, len(nums)):
            prefix[i] = prefix[i-1] + nums[i]

        total = prefix[-1]
        res = 0

        # Without any change
        freq = defaultdict(int)
        for i in range(len(nums)-1):
            left = prefix[i]
            right = total - left
            if left == right:
                res += 1
            freq[prefix[i]] += 1

        max_res = res

        # With change
        freq_left = defaultdict(int)
        prefix_sum = 0
        for i in range(len(nums)):
            new_total = total - nums[i] + k
            if new_total % 2 == 0:
                target = new_total // 2
                # left part
                cnt_left = freq_left.get(target, 0)
                # right part
                cnt_right = freq.get(target, 0) - freq_left.get(target, 0)
                current = cnt_left + cnt_right
                if current > max_res:
                    max_res = current
            prefix_sum += nums[i]
            freq_left[prefix_sum] += 1

        return max_res