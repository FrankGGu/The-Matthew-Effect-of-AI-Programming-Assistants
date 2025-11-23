import heapq

class Solution:
    def totalCost(self, costs: list[int], k: int, candidates: int) -> int:
        l, r = candidates, len(costs) - candidates - 1
        h1, h2 = [], []
        for i in range(candidates):
            heapq.heappush(h1, costs[i])
        for i in range(max(candidates, len(costs) - candidates), len(costs)):
            heapq.heappush(h2, costs[i])

        ans = 0
        for _ in range(k):
            if not h1 and not h2:
                break
            if not h1:
                ans += heapq.heappop(h2)
                if l <= r:
                    heapq.heappush(h2, costs[r])
                    r -= 1
            elif not h2:
                ans += heapq.heappop(h1)
                if l <= r:
                    heapq.heappush(h1, costs[l])
                    l += 1
            else:
                if h1[0] <= h2[0]:
                    ans += heapq.heappop(h1)
                    if l <= r:
                        heapq.heappush(h1, costs[l])
                        l += 1
                else:
                    ans += heapq.heappop(h2)
                    if l <= r:
                        heapq.heappush(h2, costs[r])
                        r -= 1
        return ans