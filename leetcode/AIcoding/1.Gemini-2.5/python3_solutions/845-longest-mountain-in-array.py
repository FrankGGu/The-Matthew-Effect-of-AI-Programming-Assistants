from typing import List

class Solution:
    def longestMountain(self, arr: List[int]) -> int:
        n = len(arr)
        if n < 3:
            return 0

        max_len = 0
        i = 0
        while i < n:
            j = i

            # Find uphill part
            # j will point to the potential peak
            up = 0
            while j + 1 < n and arr[j+1] > arr[j]:
                j += 1
                up += 1

            # Find downhill part
            # k will point to the end of the downhill slope
            down = 0
            # A mountain must have an uphill slope
            if up > 0:
                k = j
                while k + 1 < n and arr[k+1] < arr[k]:
                    k += 1
                    down += 1

                # A mountain must also have a downhill slope
                if down > 0:
                    max_len = max(max_len, up + down + 1)

                # Advance i for the next potential mountain
                # If a downhill part was found, the next potential mountain can start from its end (k)
                # If only uphill was found (down == 0), the next potential mountain can start from its peak (j)
                # This ensures we don't miss mountains that start immediately after a failed uphill
                i = k if down > 0 else j
            else:
                # No uphill from current i, so move to the next element
                # This handles cases like [5,4,3] or [1,1,2] where arr[i+1] <= arr[i]
                i += 1

            # This check prevents infinite loops if i doesn't advance, e.g., at the end of the array
            # or if arr[j+1] <= arr[j] and j was already n-1.
            # The logic for advancing i (i = k, i = j, or i += 1) already covers this.
            # If i becomes n-1 and up=0, next iteration i becomes n and loop terminates.
            # If i becomes n-1 and up>0, down=0, next iteration i becomes n-1, then up=0, then i becomes n.
            # The code is safe.

        return max_len