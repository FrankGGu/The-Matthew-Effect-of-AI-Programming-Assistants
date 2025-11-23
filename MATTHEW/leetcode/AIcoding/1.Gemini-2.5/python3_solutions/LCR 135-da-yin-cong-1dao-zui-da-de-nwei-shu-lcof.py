class Solution:
    def countAndSay(self, n: int) -> str:
        if n == 1:
            return "1"

        current_str = "1"
        for _ in range(2, n + 1):
            next_str_parts = []
            i = 0
            while i < len(current_str):
                char = current_str[i]
                count = 0
                j = i
                while j < len(current_str) and current_str[j] == char:
                    count += 1
                    j += 1
                next_str_parts.append(str(count))
                next_str_parts.append(char)
                i = j
            current_str = "".join(next_str_parts)
        return current_str