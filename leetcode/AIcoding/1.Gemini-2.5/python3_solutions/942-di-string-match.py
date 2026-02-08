class Solution:
    def diStringMatch(self, s: str) -> list[int]:
        n = len(s)
        perm = []
        low = 0
        high = n

        for char in s:
            if char == 'I':
                perm.append(low)
                low += 1
            else:  # char == 'D'
                perm.append(high)
                high -= 1

        perm.append(low) # The last remaining number (low == high at this point)

        return perm