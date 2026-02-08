class Solution:
    def minimalKSum(self, nums: list[int], k: int) -> int:
        ans = 0
        count = 0
        current_val = 1

        unique_nums = sorted(list(set(nums)))

        for x in unique_nums:
            if x <= current_val:
                current_val = x + 1
                continue

            can_pick_count = x - current_val
            actual_pick_count = min(can_pick_count, k - count)

            if actual_pick_count > 0:
                last_picked = current_val + actual_pick_count - 1
                ans += (last_picked * (last_picked + 1) // 2) - ((current_val - 1) * current_val // 2)
                count += actual_pick_count
                current_val = last_picked + 1

            if count == k:
                break

            current_val = x + 1

        if count < k:
            remaining_pick_count = k - count
            last_picked = current_val + remaining_pick_count - 1
            ans += (last_picked * (last_picked + 1) // 2) - ((current_val - 1) * current_val // 2)

        return ans