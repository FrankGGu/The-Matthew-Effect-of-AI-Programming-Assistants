class Solution:
    def smallestString(self, s: str) -> str:
        s_list = list(s)
        n = len(s_list)

        start_idx = -1
        for i in range(n):
            if s_list[i] != 'a':
                start_idx = i
                break

        if start_idx == -1:
            # If all characters are 'a', applying the operation 'a' -> 'z'
            # would make the string lexicographically larger.
            # Since we want the smallest string and can perform *at most one* operation,
            # we choose to perform zero operations.
            return s

        # Apply the operation to the first contiguous block of non-'a' characters.
        # This ensures we make the earliest possible characters smaller without
        # changing any 'a's to 'z's, which would be detrimental.
        for i in range(start_idx, n):
            if s_list[i] != 'a':
                s_list[i] = chr(ord(s_list[i]) - 1)
            else:
                # We hit an 'a'. Stop the operation here, as changing 'a' to 'z'
                # would make the string lexicographically larger.
                break

        return "".join(s_list)