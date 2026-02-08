import heapq

class Solution:
    def isPossible(self, target: List[int]) -> bool:
        if len(target) == 1:
            return target[0] == 1

        total = sum(target)
        heap = [-num for num in target]
        heapq.heapify(heap)

        while -heap[0] > 1:
            largest = -heapq.heappop(heap)
            rest = total - largest

            if rest == 1:
                return True

            if rest >= largest or rest == 0:
                return False

            new_val = largest % rest
            if new_val == 0:
                return False

            heapq.heappush(heap, -new_val)
            total = rest + new_val

        return True