import collections

class Solution:
    def minimumTotalCost(self, nums1: list[int], nums2: list[int], cost: list[int]) -> int:
        n = len(nums1)

        initial_cost = 0
        bad_indices_count = 0
        val_counts = collections.defaultdict(int)

        for i in range(n):
            if nums1[i] == nums2[i]:
                initial_cost += cost[i]
                bad_indices_count += 1
                val_counts[nums1[i]] += 1

        if bad_indices_count == 0:
            return 0

        max_freq = 0
        v_maj = -1 # Value that appears most frequently at bad indices
        for v, count in val_counts.items():
            if count > max_freq:
                max_freq = count
                v_maj = v

        # If there is no majority element among the values at bad indices,
        # we can resolve all conflicts by swapping problematic elements among themselves.
        # For any two distinct problematic values A and B at indices i and j:
        # nums1[i]=A, nums2[i]=A; nums1[j]=B, nums2[j]=B.
        # Swapping nums1[i] and nums1[j] makes nums1[i]=B and nums1[j]=A.
        # Since A != B, both indices i and j are fixed (nums1[i]!=nums2[i] and nums1[j]!=nums2[j]).
        # The cost for such a swap (cost[i]+cost[j]) is already accounted for in initial_cost.
        # Thus, no additional cost is needed.
        if max_freq * 2 <= bad_indices_count:
            return initial_cost

        # If there is a majority element v_maj, it means we have more conflicts
        # of v_maj than all other types of conflicts combined.
        # Let k_maj = max_freq (count of v_maj conflicts)
        # Let k_other = bad_indices_count - max_freq (count of other conflicts)
        # We can pair k_other v_maj conflicts with k_other other_val conflicts,
        # resolving 2 * k_other conflicts with no additional cost.
        # This leaves k_maj - k_other conflicts, all of which are v_maj.
        # These remaining conflicts (2 * max_freq - bad_indices_count) must be resolved
        # by swapping with 'good' indices.
        num_extra_swaps_needed = 2 * max_freq - bad_indices_count

        candidate_costs = []
        for i in range(n):
            # A 'good' index i can be used for an extra swap if it meets three conditions:
            # 1. It is not currently a bad index: nums1[i] != nums2[i].
            # 2. Swapping nums1[i] (its original value) with v_maj must fix the bad index.
            #    This means nums1[i] (original value) should not be v_maj.
            #    (i.e., new nums1[bad_idx] = nums1[i] != v_maj = nums2[bad_idx])
            # 3. After the swap, the good index i must remain good.
            #    This means the new nums1[i] (which becomes v_maj) must not be equal to nums2[i].
            #    (i.e., v_maj != nums2[i])
            if nums1[i] != nums2[i] and nums1[i] != v_maj and v_maj != nums2[i]:
                candidate_costs.append(cost[i])

        # If we don't have enough suitable good indices, it's impossible.
        if len(candidate_costs) < num_extra_swaps_needed:
            return -1

        # Sort the candidate costs and add the smallest ones to the total cost.
        candidate_costs.sort()
        for i in range(num_extra_swaps_needed):
            initial_cost += candidate_costs[i]

        return initial_cost