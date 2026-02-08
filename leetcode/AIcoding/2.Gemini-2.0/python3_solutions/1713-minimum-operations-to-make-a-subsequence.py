class Solution:
    def minOperations(self, target: List[int], arr: List[int]) -> int:
        pos = {}
        for i, num in enumerate(target):
            pos[num] = i

        subsequence = []
        for num in arr:
            if num in pos:
                subsequence.append(pos[num])

        tails = []
        for num in subsequence:
            if not tails or num > tails[-1]:
                tails.append(num)
            else:
                l, r = 0, len(tails) - 1
                while l < r:
                    mid = (l + r) // 2
                    if tails[mid] < num:
                        l = mid + 1
                    else:
                        r = mid
                tails[l] = num

        return len(target) - len(tails)