def maximumRobots(self, chargeTimes: List[int], budget: int) -> int:
    from collections import deque
    n = len(chargeTimes)
    left = 0
    maxCharge = deque()
    totalCost = 0
    result = 0

    for right in range(n):
        totalCost += chargeTimes[right]
        while maxCharge and maxCharge[-1] < chargeTimes[right]:
            maxCharge.pop()
        maxCharge.append(chargeTimes[right])

        while totalCost + maxCharge[0] > budget:
            totalCost -= chargeTimes[left]
            if maxCharge[0] == chargeTimes[left]:
                maxCharge.popleft()
            left += 1

        result = max(result, right - left + 1)

    return result