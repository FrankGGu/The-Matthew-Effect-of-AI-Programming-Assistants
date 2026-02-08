def minDays(bloomDay, m, k):
    n = len(bloomDay)
    if m * k > n:
        return -1

    def possible(days):
        bouquets = 0
        flowers = 0
        for bloom in bloomDay:
            if bloom <= days:
                flowers += 1
                if flowers == k:
                    bouquets += 1
                    flowers = 0
            else:
                flowers = 0
        return bouquets >= m

    left, right = 1, max(bloomDay)
    ans = right

    while left <= right:
        mid = (left + right) // 2
        if possible(mid):
            ans = mid
            right = mid - 1
        else:
            left = mid + 1

    return ans