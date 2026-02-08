class Solution:
    def minTimeToType(self, word: str) -> int:
        total_time = 0
        current_char = 'a'

        for target_char in word:
            diff = abs(ord(target_char) - ord(current_char))

            # Calculate the minimum time to move, considering the circular dial
            move_time = min(diff, 26 - diff)

            total_time += move_time
            total_time += 1  # Time to type the character

            current_char = target_char

        return total_time