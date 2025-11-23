import heapq

class Solution:
    def magicTower(self, nums: list[int]) -> int:
        current_health = 0
        operations = 0
        # A min-heap to store negative health changes encountered so far.
        # When current_health drops to 0 or below, we need to "undo" the effect
        # of the largest health drop (most negative value) to bring health back up.
        # Python's heapq is a min-heap, so storing negative values directly works:
        # popping will give the smallest (most negative) value.
        pq = [] 

        # First, check if it's even possible to complete the game.
        # If the sum of all health changes is negative, it's impossible to
        # maintain positive health, regardless of initial health or operations.
        if sum(nums) < 0:
            return -1

        for num in nums:
            current_health += num

            # If the current room causes a health drop, add it to the priority queue.
            if num < 0:
                heapq.heappush(pq, num)

            # If current_health drops to 0 or below, we must perform an operation.
            # This means we "move" an earlier negative health change to the start,
            # effectively increasing our starting health to compensate for it.
            # To minimize operations, we undo the largest health drop (most negative value)
            # encountered so far, as this provides the biggest immediate health boost.
            while current_health < 0:
                operations += 1
                # Get the most negative value from the heap (e.g., -10 is more negative than -4)
                val_to_undo = heapq.heappop(pq)
                # Add its absolute value back to current_health.
                # This simulates having started with -val_to_undo more health,
                # effectively "removing" val_to_undo from the sequence of health changes.
                current_health += -val_to_undo

        return operations