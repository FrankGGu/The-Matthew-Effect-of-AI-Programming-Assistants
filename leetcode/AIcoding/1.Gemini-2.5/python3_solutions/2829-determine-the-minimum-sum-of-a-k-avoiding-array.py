class Solution:
    def minimumSum(self, n: int, k: int) -> int:
        chosen_numbers = set()
        current_sum = 0
        num_count = 0
        candidate = 1

        while num_count < n:
            # Check if adding 'candidate' would violate the k-avoiding condition.
            # A number 'candidate' can be added if its "complement" (k - candidate)
            # is not already present in the array.
            # We only consider positive integers, so k - candidate must be > 0 to be a potential conflict.
            # However, since candidate starts from 1 and increases, k - candidate will only be positive
            # if candidate < k. If candidate >= k, then k - candidate <= 0, which cannot be in chosen_numbers
            # (as chosen_numbers only contains positive integers). So, the check (k - candidate) not in chosen_numbers
            # implicitly handles this.

            if (k - candidate) not in chosen_numbers:
                chosen_numbers.add(candidate)
                current_sum += candidate
                num_count += 1

            candidate += 1

        return current_sum