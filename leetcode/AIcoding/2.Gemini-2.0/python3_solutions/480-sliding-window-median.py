import heapq

class Solution:
    def medianSlidingWindow(self, nums: list[int], k: int) -> list[float]:
        small, large = [], []
        result = []

        def add(num):
            if not small or num <= -small[0]:
                heapq.heappush(small, -num)
            else:
                heapq.heappush(large, num)
            rebalance()

        def remove(num):
            if num <= -small[0]:
                small.remove(-num)
                heapq.heapify(small)
            else:
                large.remove(num)
                heapq.heapify(large)
            rebalance()

        def rebalance():
            if len(small) > len(large) + 1:
                heapq.heappush(large, -heapq.heappop(small))
            elif len(large) > len(small):
                heapq.heappush(small, -heapq.heappop(large))

        for i in range(k):
            add(nums[i])

        if k % 2 == 0:
            result.append((-small[0] + large[0]) / 2)
        else:
            result.append(-small[0])

        for i in range(k, len(nums)):
            remove(nums[i - k])
            add(nums[i])

            if k % 2 == 0:
                result.append((-small[0] + large[0]) / 2)
            else:
                result.append(-small[0])

        return result