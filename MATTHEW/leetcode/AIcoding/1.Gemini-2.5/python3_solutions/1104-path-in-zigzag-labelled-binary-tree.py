import math

class Solution:
    def pathInZigZagTree(self, label: int) -> list[int]:
        path = []
        current_label = label

        while current_label >= 1:
            path.append(current_label)

            l = current_label.bit_length()

            # Calculate min and max values for the current level
            min_val_l = 1 << (l - 1)
            max_val_l = (1 << l) - 1

            if l % 2 == 1:  # Odd level (e.g., 1, 3, 5) - labels are left-to-right
                current_label = current_label // 2
            else:  # Even level (e.g., 2, 4, 6) - labels are right-to-left
                # 1. Find the "normal" tree equivalent of current_label
                # This is min_val_l + max_val_l - current_label
                normal_equivalent_current = min_val_l + max_val_l - current_label

                # 2. Find the parent of this "normal" equivalent in a normal tree.
                parent_normal_equivalent = normal_equivalent_current // 2

                # 3. The parent is at level l-1. Since l is even, l-1 is odd.
                # Odd levels are labelled left-to-right, so the "normal" equivalent
                # is already its actual zigzag label.
                current_label = parent_normal_equivalent

        path.reverse()
        return path