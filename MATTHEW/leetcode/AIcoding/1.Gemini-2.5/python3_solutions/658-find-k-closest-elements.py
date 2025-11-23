import bisect
import collections

class Solution:
    def findClosestElements(self, arr: list[int], k: int, x: int) -> list[int]:
        n = len(arr)

        idx = bisect.bisect_left(arr, x)

        left = idx - 1
        right = idx

        result = collections.deque()

        while len(result) < k:
            if left < 0:
                result.append(arr[right])
                right += 1
            elif right >= n:
                result.appendleft(arr[left])
                left -= 1
            else:
                diff_left = abs(arr[left] - x)
                diff_right = abs(arr[right] - x)

                if diff_left <= diff_right:
                    result.appendleft(arr[left])
                    left -= 1
                else:
                    result.append(arr[right])
                    right += 1

        return list(result)