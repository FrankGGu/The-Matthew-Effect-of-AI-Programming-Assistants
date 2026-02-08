class Solution:
    def bestRotation(self, nums: list[int]) -> int:
        n = len(nums)

        # `change[k]` will store the net change in score when rotating from `k-1` to `k`.
        # Initialize `change` array with zeros.
        change = [0] * n

        for i in range(n):
            # For each element nums[i] at original index i:
            # It contributes a point if its new index j satisfies nums[i] <= j.
            # The new index j for nums[i] after rotation k is (i - k + n) % n.

            # This element `nums[i]` stops contributing a point when its new index `j`
            # becomes `nums[i] - 1` (or less).
            # The first `k` for which `j = nums[i] - 1` is when:
            # (i - k + n) % n = nums[i] - 1
            # i - k = nums[i] - 1 (mod n)
            # k = i - (nums[i] - 1) (mod n)
            # k = (i - nums[i] + 1 + n) % n
            # Let this be `k_stop_point`. At this `k`, `nums[i]` lands at `nums[i]-1`,
            # so it stops contributing. Thus, the score decreases by 1 at `k_stop_point`.
            k_stop_point = (i - nums[i] + 1 + n) % n
            change[k_stop_point] -= 1

            # This element `nums[i]` starts contributing a point again (after wrapping around)
            # when its new index `j` becomes `n-1`. This happens after `j` has passed `0, 1, ..., nums[i]-1`.
            # The new index `j` for `nums[i]` is `0` when `k = i`.
            # The new index `j` for `nums[i]` is `n-1` when `k = i+1`.
            # (i - k + n) % n = n - 1
            # i - k = n - 1 (mod n)
            # k = i - (n - 1) (mod n)
            # k = (i + 1 + n) % n
            # Let this be `k_start_point_again`. At this `k`, `nums[i]` lands at `n-1`.
            # If `nums[i] <= n-1`, it starts contributing. If `nums[i] = n`, it never contributes
            # and the +1 and -1 changes for this specific `k` will cancel out, which is correct.
            # Thus, the score increases by 1 at `k_start_point_again`.
            k_start_point_again = (i + 1 + n) % n
            change[k_start_point_again] += 1

        # Calculate score for k=0 explicitly.
        # For k=0, nums[i] is at index i. It contributes if nums[i] <= i.
        current_score = 0
        for i in range(n):
            if nums[i] <= i:
                current_score += 1

        max_score = current_score
        best_k = 0

        # Calculate scores for k=1 to n-1 using the difference array.
        # score[k] = score[k-1] + change[k].
        for k in range(1, n):
            current_score += change[k]
            if current_score > max_score:
                max_score = current_score
                best_k = k

        return best_k