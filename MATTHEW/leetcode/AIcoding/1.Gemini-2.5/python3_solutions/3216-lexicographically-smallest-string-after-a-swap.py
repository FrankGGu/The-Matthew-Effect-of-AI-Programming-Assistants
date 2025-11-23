class Solution:
    def smallestStringWithOneSwap(self, s: str) -> str:
        n = len(s)
        if n <= 1:
            return s

        s_list = list(s)

        for i in range(n - 1):
            # Find the smallest character in the remaining suffix s[i+1:]
            # and its rightmost index.
            # We want to find a character smaller than s_list[i].
            # If multiple such characters exist, we pick the smallest one.
            # If multiple occurrences of the smallest character exist,
            # we pick the rightmost one to minimize the impact on the middle part of the string.

            min_char_in_suffix = s_list[i]
            swap_idx = -1

            # Iterate from right to left in the suffix to find the rightmost smallest char
            for j in range(n - 1, i, -1):
                if s_list[j] < min_char_in_suffix:
                    min_char_in_suffix = s_list[j]
                    swap_idx = j

            # If we found a character in the suffix smaller than s_list[i]
            if swap_idx != -1:
                # Perform the swap
                s_list[i], s_list[swap_idx] = s_list[swap_idx], s_list[i]
                # Since we found the first possible improvement from the left,
                # this single swap will result in the lexicographically smallest string.
                # Any further swap would either make the prefix worse or not improve it enough.
                return "".join(s_list)

        # If no swap was found that improves the string, return the original string
        return s