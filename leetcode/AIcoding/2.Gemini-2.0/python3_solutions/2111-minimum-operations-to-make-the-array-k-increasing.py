class Solution:
    def kIncreasing(self, arr: List[int], k: int) -> int:
        def longest_non_decreasing_subsequence(sub_arr):
            tails = []
            for num in sub_arr:
                if not tails or num >= tails[-1]:
                    tails.append(num)
                else:
                    l, r = 0, len(tails) - 1
                    while l <= r:
                        mid = (l + r) // 2
                        if tails[mid] <= num:
                            l = mid + 1
                        else:
                            r = mid - 1
                    tails[l] = num
            return len(tails)

        count = 0
        for i in range(k):
            sub_arr = arr[i::k]
            count += len(sub_arr) - longest_non_decreasing_subsequence(sub_arr)
        return count