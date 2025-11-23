class Solution:
    def subarrayBitwiseORs(self, arr: list[int]) -> int:
        all_ors = set()
        current_ors_ending_at_prev_idx = set()

        for x in arr:
            current_ors_ending_at_this_idx = {x} 
            for y in current_ors_ending_at_prev_idx:
                current_ors_ending_at_this_idx.add(y | x)

            all_ors.update(current_ors_ending_at_this_idx)
            current_ors_ending_at_prev_idx = current_ors_ending_at_this_idx

        return len(all_ors)