class Solution:
    def maximumGain(self, s: str, x: int, y: int) -> int:

        def remove_pattern(s_chars, pattern_str, score_val):
            stack = []
            current_score = 0
            for char in s_chars:
                if char == pattern_str[1] and stack and stack[-1] == pattern_str[0]:
                    stack.pop()
                    current_score += score_val
                else:
                    stack.append(char)
            return "".join(stack), current_score

        total_score = 0

        if x >= y:
            # Prioritize "ab"
            s_remaining_after_ab, score1 = remove_pattern(s, "ab", x)
            total_score += score1

            # Then remove "ba" from the remaining string
            _, score2 = remove_pattern(s_remaining_after_ab, "ba", y)
            total_score += score2
        else:
            # Prioritize "ba"
            s_remaining_after_ba, score1 = remove_pattern(s, "ba", y)
            total_score += score1

            # Then remove "ab" from the remaining string
            _, score2 = remove_pattern(s_remaining_after_ba, "ab", x)
            total_score += score2

        return total_score