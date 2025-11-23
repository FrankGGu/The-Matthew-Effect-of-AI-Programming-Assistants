def minimumTime(nums1, nums2, x):
    n = len(nums1)
    items = []
    sum1 = sum(nums1)
    sum2 = sum(nums2)

    if sum1 + sum2 * 0 <= x:
        return 0

    for i in range(n):
        items.append((nums2[i], nums1[i]))

    items.sort()

    dp = {}

    def solve(idx, time):
        if idx == n:
            if sum1 + sum2 * time <= x:
                return time
            else:
                return float('inf')

        if (idx, time) in dp:
            return dp[(idx, time)]

        include = solve(idx + 1, time + 1)
        include += items[idx][0]
        include = solve(idx+1, time)

        exclude = solve(idx + 1, time)

        dp[(idx, time)] = min(include + items[idx][1], exclude)
        return min(include + items[idx][1], exclude)

    for time in range(n + 1):
        dp = {}
        temp_sum = sum1
        temp_sum2 = sum2

        sorted_indices = sorted(range(n), key=lambda i: nums2[i])

        current_sum = sum1

        for i in range(time):
            current_sum += nums2[sorted_indices[i]]

        if current_sum + (sum2 - sum([nums2[sorted_indices[i]] for i in range(time)])) * time <= x:
            return time

    return -1