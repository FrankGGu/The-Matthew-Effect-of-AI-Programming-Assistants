from collections import Counter, deque

class Solution:
    def isTransformable(self, s: str, t: str) -> bool:
        if Counter(s) != Counter(t):
            return False

        # Store indices of each digit in s
        # pos[digit] will be a deque of indices where 'digit' appears in s
        pos = [deque() for _ in range(10)]
        for i, char_s in enumerate(s):
            pos[int(char_s)].append(i)

        for char_t in t:
            target_digit = int(char_t)

            # Get the first available index of target_digit in s
            # If pos[target_digit] is empty, it means we've used all occurrences
            # This case should ideally not happen if Counter(s) == Counter(t) and logic is correct
            if not pos[target_digit]:
                return False 

            current_s_idx = pos[target_digit][0]

            # Check if any smaller digit is blocking target_digit from moving to the front
            # If there's a digit 'd' smaller than 'target_digit'
            # and its first available index 'pos[d][0]' is less than 'current_s_idx',
            # it means 'd' appears before 'target_digit' in s.
            # When sorting a substring ending at 'current_s_idx', 'd' would come before 'target_digit'.
            # Thus, 'target_digit' cannot be moved to the current target position in t.
            for d in range(target_digit):
                if pos[d] and pos[d][0] < current_s_idx:
                    return False

            # If no smaller digit is blocking, we can "use" this target_digit
            # Remove its index from the deque
            pos[target_digit].popleft()

        return True