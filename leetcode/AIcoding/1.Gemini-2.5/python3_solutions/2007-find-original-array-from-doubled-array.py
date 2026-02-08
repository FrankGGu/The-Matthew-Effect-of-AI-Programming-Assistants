import collections

class Solution:
    def findOriginalArray(self, changed: list[int]) -> list[int]:
        if len(changed) % 2 != 0:
            return []

        freq = collections.Counter(changed)
        original = []

        # Iterate through numbers in sorted order. This ensures that for any number 'x',
        # we process 'x' before '2x' (if x > 0) or handle '0' consistently.
        # This is crucial because 'x' might also be a '2y' for some smaller 'y'.
        # By processing 'x' first, we ensure we find its required '2x' partner.
        for num in sorted(freq.keys()):
            if freq[num] == 0:
                # All occurrences of this number have already been paired as '2y' or 'x'
                continue

            if num == 0:
                # For zeros, they must be paired with other zeros.
                # So, the count of zeros must be even.
                if freq[0] % 2 != 0:
                    return []
                original.extend([0] * (freq[0] // 2))
                freq[0] = 0  # All zeros are now processed
            else:
                # For non-zero numbers, we need to find their double.
                # If we don't have enough '2 * num's for the current 'num's,
                # then it's impossible to form the original array.
                if freq[2 * num] < freq[num]:
                    return []

                original.extend([num] * freq[num])
                freq[2 * num] -= freq[num]
                freq[num] = 0  # All occurrences of num are now paired

        return original