class Solution:
    def maxEnvelopes(self, envelopes: List[List[int]]) -> int:
        envelopes.sort(key=lambda x: (x[0], -x[1]))
        tails = []
        for env in envelopes:
            width, height = env
            if not tails or height > tails[-1]:
                tails.append(height)
            else:
                l, r = 0, len(tails) - 1
                while l <= r:
                    mid = (l + r) // 2
                    if tails[mid] < height:
                        l = mid + 1
                    else:
                        r = mid - 1
                tails[l] = height
        return len(tails)