class Solution:
    def longestAwesome(self, s: str) -> int:
        mask_map = {0: -1}  # Stores {mask: first_index_ending_before_current_char}
        current_mask = 0
        max_len = 0

        for j in range(len(s)):
            digit = int(s[j])
            current_mask ^= (1 << digit)

            # Case 1: Substring s[mask_map[current_mask]+1 ... j] has an awesome property (all even counts)
            if current_mask in mask_map:
                max_len = max(max_len, j - mask_map[current_mask])

            # Case 2: Substring s[mask_map[target_mask]+1 ... j] has an awesome property (one odd count)
            # This means current_mask ^ target_mask is a power of 2 (1 << k)
            # So, target_mask = current_mask ^ (1 << k)
            for k in range(10):
                target_mask = current_mask ^ (1 << k)
                if target_mask in mask_map:
                    max_len = max(max_len, j - mask_map[target_mask])

            # Store the first occurrence of current_mask if not already present
            if current_mask not in mask_map:
                mask_map[current_mask] = j

        return max_len