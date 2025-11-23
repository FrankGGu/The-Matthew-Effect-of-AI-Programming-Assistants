class Solution:
    def countAndSay(self, n: int) -> str:
        if n == 1:
            return "1"

        current_sequence = "1"
        for _ in range(n - 1):
            next_sequence_parts = []
            i = 0
            while i < len(current_sequence):
                char = current_sequence[i]
                count = 0
                j = i
                while j < len(current_sequence) and current_sequence[j] == char:
                    count += 1
                    j += 1
                next_sequence_parts.append(str(count))
                next_sequence_parts.append(char)
                i = j
            current_sequence = "".join(next_sequence_parts)
        return current_sequence