class Solution:
    def decodeAtIndex(self, S: str, K: int) -> str:
        length = 0

        # Calculate the total length of the decoded string
        for char in S:
            if '0' <= char <= '9':
                length *= int(char)
            else:
                length += 1

        # Iterate backwards to find the K-th character
        for i in range(len(S) - 1, -1, -1):
            char = S[i]

            # Adjust K to be within the current segment's length
            # K is 1-indexed. If K is a multiple of length, it means it's the last character.
            K %= length
            if K == 0:
                K = length

            if '0' <= char <= '9':
                # If the character is a digit, it means the current segment was repeated.
                # We effectively go back to the string before this repetition.
                # So, divide the length by the digit.
                length //= int(char)
            else:
                # If the character is a letter.
                # If K matches the current length, this letter is our answer.
                if K == length:
                    return char
                # Otherwise, this letter is not the target, so we decrement the length
                # as we move to the segment before this letter.
                length -= 1

        return "" # Should not be reached given problem constraints (K will always be found)