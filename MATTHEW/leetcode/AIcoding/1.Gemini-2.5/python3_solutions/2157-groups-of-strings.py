class DSU:
    def __init__(self, mask_to_count_map):
        self.parent = {mask: mask for mask in mask_to_count_map.keys()}
        self.group_size = {mask: count for mask, count in mask_to_count_map.items()}
        self.num_groups = len(mask_to_count_map)

    def find(self, i):
        if self.parent[i] == i:
            return i
        self.parent[i] = self.find(self.parent[i])
        return self.parent[i]

    def union(self, i, j):
        root_i = self.find(i)
        root_j = self.find(j)
        if root_i != root_j:
            self.parent[root_j] = root_i
            self.group_size[root_i] += self.group_size[root_j]
            self.num_groups -= 1
            return True
        return False

class Solution:
    def groupsOfStrings(self, words: list[str]) -> list[int]:
        mask_to_count = {}
        for word in words:
            mask = 0
            for char_code in map(ord, word):
                mask |= (1 << (char_code - ord('a')))
            mask_to_count[mask] = mask_to_count.get(mask, 0) + 1

        dsu = DSU(mask_to_count)

        unique_masks = list(mask_to_count.keys())

        for mask in unique_masks:
            # Check for 1-bit differences (deletion or addition of a character in terms of bitmask)
            for i in range(26):
                # Try deleting character 'i' if it's present in the mask
                if (mask >> i) & 1: 
                    mask_after_deletion = mask ^ (1 << i)
                    if mask_after_deletion in mask_to_count:
                        dsu.union(mask, mask_after_deletion)
                # Try adding character 'i' if it's not present in the mask
                else:
                    mask_after_addition = mask | (1 << i)
                    if mask_after_addition in mask_to_count:
                        dsu.union(mask, mask_after_addition)

            # Check for 2-bit differences (changing one character to another in terms of bitmask)
            # This means removing a bit 'j' and adding a bit 'k', where j != k.
            for j in range(26): # Iterate through bits to potentially remove
                if (mask >> j) & 1: # If j-th bit is set in 'mask'
                    for k in range(26): # Iterate through bits to potentially add
                        if not ((mask >> k) & 1): # If k-th bit is NOT set in 'mask'
                            # This condition ensures j != k, as j is present and k is not.
                            mask_changed = (mask ^ (1 << j)) | (1 << k)
                            if mask_changed in mask_to_count:
                                dsu.union(mask, mask_changed)

        max_group_size = 0
        # After processing all connections, find the largest group size
        for root_mask in dsu.parent:
            if dsu.parent[root_mask] == root_mask: # If it's a root of a component
                max_group_size = max(max_group_size, dsu.group_size[root_mask])

        return [dsu.num_groups, max_group_size]