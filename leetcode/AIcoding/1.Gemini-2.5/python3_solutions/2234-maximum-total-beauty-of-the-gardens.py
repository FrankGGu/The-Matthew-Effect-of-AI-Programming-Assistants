import bisect

class Solution:
    def maximumBeauty(self, flowers: list[int], newFlowers: int, target: int, full: int, partial: int) -> int:
        n = len(flowers)
        flowers.sort()

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + flowers[i]

        max_total_beauty = 0
        cost_to_make_full = 0

        # Iterate through the number of gardens we make complete.
        # `num_complete` goes from 0 to n.
        # When `num_complete = k`, the k rightmost gardens (flowers[n-k]...flowers[n-1]) are considered complete.
        # The remaining `n-k` gardens (flowers[0]...flowers[n-k-1]) are considered for partial beauty.
        for num_complete in range(n + 1):
            if num_complete > 0:
                # Add the cost for the new garden being made complete.
                # This is `flowers[n - num_complete]`, which is the leftmost garden among the `num_complete` rightmost ones.
                # If it's already >= target, cost is 0. Otherwise, target - flowers[i].
                cost_to_make_full += max(0, target - flowers[n - num_complete])

            if cost_to_make_full > newFlowers:
                # If we don't have enough flowers to make these complete gardens,
                # we won't have enough for more complete gardens either (since we pick from largest counts).
                break

            remaining_newFlowers = newFlowers - cost_to_make_full
            current_beauty = num_complete * full

            num_partial_gardens = n - num_complete
            if num_partial_gardens == 0:
                # All gardens are complete, no partial gardens.
                max_total_beauty = max(max_total_beauty, current_beauty)
                continue

            # Binary search for the maximum possible minimum flower count (m)
            # for the partial gardens (flowers[0]...flowers[num_partial_gardens - 1]).
            # `m` can range from 0 to `target - 1`.
            left, right = 0, target - 1
            max_min_flowers_for_partial = 0

            while left <= right:
                mid = left + (right - left) // 2

                # Find the index of the first garden in the partial set that has >= `mid` flowers.
                # `bisect_left` searches in `flowers[0 : num_partial_gardens]`.
                idx_first_ge_mid = bisect.bisect_left(flowers, mid, 0, num_partial_gardens)

                # Calculate cost to bring gardens `flowers[0]...flowers[idx_first_ge_mid - 1]` up to `mid`.
                # These are the gardens that currently have < `mid` flowers.
                # The sum of flowers in these gardens is `prefix_sum[idx_first_ge_mid]`.
                # The total needed if they all become `mid` is `mid * idx_first_ge_mid`.
                cost_for_partial = mid * idx_first_ge_mid - prefix_sum[idx_first_ge_mid]

                if cost_for_partial <= remaining_newFlowers:
                    max_min_flowers_for_partial = mid
                    left = mid + 1
                else:
                    right = mid - 1

            current_beauty += max_min_flowers_for_partial * partial
            max_total_beauty = max(max_total_beauty, current_beauty)

        return max_total_beauty