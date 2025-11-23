def earliestSecondToMarkIndices(nums, changeIndices):
    n = len(nums)
    m = len(changeIndices)

    def check(t):
        last_mark = [-1] * n
        for i in range(t):
            last_mark[changeIndices[i] - 1] = i

        marked = [False] * n
        seconds_left = 0
        for i in range(t):
            idx = changeIndices[i] - 1
            if last_mark[idx] == i:
                if seconds_left >= nums[idx]:
                    seconds_left -= nums[idx]
                    marked[idx] = True
                else:
                    return False
            else:
                seconds_left += 1

        return all(marked)

    l, r = 1, m
    ans = -1
    while l <= r:
        mid = (l + r) // 2
        if check(mid):
            ans = mid
            r = mid - 1
        else:
            l = mid + 1
    return ans