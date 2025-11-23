import heapq

class Solution:
    def minimumCost(self, nums: List[int], k: int, dist: int) -> int:
        n = len(nums)
        total = nums[0]
        k -= 1
        res = float('inf')
        left_heap = []
        right_heap = []
        left_sum = 0
        right_sum = 0
        left_size = 0

        for i in range(1, n):
            current = nums[i]
            if left_size < k:
                heapq.heappush(left_heap, -current)
                left_sum += current
                left_size += 1
            else:
                if left_heap and current > -left_heap[0]:
                    val = -heapq.heappop(left_heap)
                    left_sum -= val
                    heapq.heappush(right_heap, val)
                    right_sum += val
                    heapq.heappush(left_heap, -current)
                    left_sum += current
                else:
                    heapq.heappush(right_heap, current)
                    right_sum += current

            if i > dist + 1:
                remove_pos = i - dist - 1
                remove_val = nums[remove_pos]
                if left_heap and remove_val <= -left_heap[0]:
                    left_sum -= remove_val
                    left_size -= 1
                    if remove_val == -left_heap[0]:
                        heapq.heappop(left_heap)
                    else:
                        left_heap.remove(-remove_val)
                        heapq.heapify(left_heap)
                    if right_heap:
                        val = heapq.heappop(right_heap)
                        right_sum -= val
                        heapq.heappush(left_heap, -val)
                        left_sum += val
                        left_size += 1
                else:
                    right_sum -= remove_val
                    right_heap.remove(remove_val)
                    heapq.heapify(right_heap)

            if i >= dist:
                if left_size == k:
                    res = min(res, total + left_sum)

        return res