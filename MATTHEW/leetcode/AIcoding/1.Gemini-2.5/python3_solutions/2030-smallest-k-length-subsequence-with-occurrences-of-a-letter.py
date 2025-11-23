class Solution:
    def smallestSubsequence(self, s: str, k: int, letter: str, repetition: int) -> str:
        n = len(s)

        suffix_letter_counts = [0] * (n + 1)
        for i in range(n - 1, -1, -1):
            suffix_letter_counts[i] = suffix_letter_counts[i+1]
            if s[i] == letter:
                suffix_letter_counts[i] += 1

        stack = []
        current_letter_count = 0

        for i in range(n):
            char = s[i]

            while stack and stack[-1] > char:
                top_char = stack[-1]

                can_pop_length = (len(stack) - 1) + (n - i) >= k

                can_pop_repetition = True
                if top_char == letter:
                    if (current_letter_count - 1) + suffix_letter_counts[i+1] < repetition:
                        can_pop_repetition = False

                if can_pop_length and can_pop_repetition:
                    popped_char = stack.pop()
                    if popped_char == letter:
                        current_letter_count -= 1
                else:
                    break

            if len(stack) < k:
                can_push_for_repetition = (char == letter) or \
                                          (current_letter_count + suffix_letter_counts[i+1] >= repetition)

                if can_push_for_repetition:
                    stack.append(char)
                    if char == letter:
                        current_letter_count += 1

        return "".join(stack)