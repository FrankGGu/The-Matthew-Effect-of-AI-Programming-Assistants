import collections

class Solution:
    def findLatestStep(self, arr: list[int], m: int) -> int:
        n = len(arr)

        # length[i] stores the length of the group that 'i' belongs to.
        # This array is used to quickly determine the lengths of adjacent groups
        # by checking length[pos-1] and length[pos+1].
        # Only the endpoints of a group store its full length.
        # If length[i] is 0, it means position 'i' is '0'.
        # We use 1-based indexing for positions, so array size n+2 for padding.
        length = [0] * (n + 2)

        # groups_count[s] stores the number of groups of size 's'.
        groups_count = collections.Counter()

        ans = -1

        # Iterate through each step, where arr[i] is the position that turns to '1'.
        for i, pos in enumerate(arr):
            # pos is 1-indexed.

            # Get lengths of adjacent groups.
            # If length[pos-1] > 0, it means pos-1 is '1' and part of a group.
            # length[pos-1] gives the length of that group.
            left_len = length[pos - 1]
            right_len = length[pos + 1]

            # If there was an existing group to the left, decrement its count
            # as it will now merge or extend.
            if left_len > 0:
                groups_count[left_len] -= 1

            # If there was an existing group to the right, decrement its count
            # as it will now merge or extend.
            if right_len > 0:
                groups_count[right_len] -= 1

            # Calculate the new combined length.
            # The new '1' at 'pos' combines with any adjacent '1's.
            new_len = 1 + left_len + right_len

            # Increment the count for the new group size.
            groups_count[new_len] += 1

            # Update the endpoints of the new combined group.
            # The new group starts at (pos - left_len) and ends at (pos + right_len).
            # We update the 'length' array at these endpoints to reflect the new_len.
            length[pos - left_len] = new_len
            length[pos + right_len] = new_len

            # After updating group counts, check if there is at least one group of size 'm'.
            if groups_count[m] > 0:
                ans = i + 1 # Store the current step (1-indexed).

        return ans