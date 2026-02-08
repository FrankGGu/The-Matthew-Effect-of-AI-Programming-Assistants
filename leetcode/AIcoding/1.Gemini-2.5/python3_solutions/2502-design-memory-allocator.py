class Allocator:

    def __init__(self, n: int):
        self.n = n
        self.memory = [0] * n
        # next_non_zero[i] stores the index of the first non-zero element at or after i.
        # If all elements from i to n-1 are zero, it stores n.
        self.next_non_zero = [0] * (n + 1)

        # Initialize next_non_zero array
        self.next_non_zero[n] = n # Sentinel value for the end of memory
        for i in range(n - 1, -1, -1):
            # If memory[i] is non-zero, then i is the first non-zero element at or after i.
            # Otherwise, it's the same as the first non-zero element at or after i+1.
            self.next_non_zero[i] = i if self.memory[i] != 0 else self.next_non_zero[i + 1]

    def allocate(self, size: int, mID: int) -> int:
        for i in range(self.n - size + 1):
            # Check if there are 'size' consecutive zeros starting at index i.
            # This is true if the first non-zero element at or after i is at least i + size.
            if self.next_non_zero[i] - i >= size:
                # Found a suitable block starting at index i.

                # Update the memory array for the allocated block
                for j in range(size):
                    self.memory[i + j] = mID

                # Update the next_non_zero array
                # For elements within the allocated block (from i to i+size-1),
                # they are now non-zero, so next_non_zero[k] should be k.
                for k in range(i, i + size):
                    self.next_non_zero[k] = k

                # Propagate updates backwards from i-1.
                # If memory[k] (for k < i) was 0, its next_non_zero[k] would have pointed
                # to the first non-zero element at or after k+1.
                # Now, since memory[i] is non-zero, next_non_zero[i] is i.
                # So, any previous next_non_zero[k] (k < i) that was pointing past i
                # and memory[k] is 0, should now point to i.
                current_ptr_for_zeros = i 
                for k in range(i - 1, -1, -1):
                    if self.memory[k] == 0:
                        self.next_non_zero[k] = current_ptr_for_zeros
                    else:
                        # Stop propagation if we hit a non-zero element, as it breaks the chain of zeros.
                        break

                return i # Return the starting index of the allocated block

        return -1 # No suitable block found

    def free(self, mID: int) -> int:
        freed_count = 0

        # Mark all cells allocated to mID as 0
        for i in range(self.n):
            if self.memory[i] == mID:
                self.memory[i] = 0
                freed_count += 1

        # After freeing memory, the next_non_zero array needs to be updated.
        # The simplest and safest way to ensure correctness after multiple changes
        # is to rebuild the next_non_zero array from scratch.
        self.next_non_zero[self.n] = self.n # Reset sentinel
        for i in range(self.n - 1, -1, -1):
            self.next_non_zero[i] = i if self.memory[i] != 0 else self.next_non_zero[i + 1]

        return freed_count