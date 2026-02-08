class Solution:
    def robotWithString(self, s: str) -> str:
        n = len(s)
        if n == 0:
            return ""

        # Precompute min_char_suffix: min_char_suffix[i] stores the minimum character
        # in the suffix s[i:].
        min_char_suffix = [''] * n
        min_char_suffix[n - 1] = s[n - 1]
        for i in range(n - 2, -1, -1):
            min_char_suffix[i] = min(s[i], min_char_suffix[i + 1])

        ans = []
        stack = []

        # Iterate through the input string s
        for i in range(n):
            current_s_char = s[i]

            # While the stack is not empty and the character on top of the stack
            # is less than or equal to the minimum character in the remaining
            # part of s (from s[i] onwards), pop from stack and append to ans.
            # This is because stack.top() is the smallest available character
            # that can be appended now, and it's also smaller than or equal to
            # any character we will encounter from s later.
            while stack and stack[-1] <= min_char_suffix[i]:
                ans.append(stack.pop())

            # Always push the current character from s onto the stack.
            # This means we are delaying its decision to be appended.
            stack.append(current_s_char)

        # After processing all characters from s, pop any remaining characters
        # from the stack and append them to ans. They will be popped in
        # reverse order of their push, which is correct for lexicographical
        # order when no smaller characters are left in s.
        while stack:
            ans.append(stack.pop())

        return "".join(ans)