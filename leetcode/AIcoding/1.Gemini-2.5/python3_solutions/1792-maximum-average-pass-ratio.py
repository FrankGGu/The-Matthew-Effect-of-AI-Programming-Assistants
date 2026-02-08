import heapq

class Solution:
    def maxAverageRatio(self, classes: list[list[int]], extraStudents: int) -> float:

        def calculate_increase(passed, total):
            # The increase in pass ratio by adding one student to a class (passed, total)
            # is (passed + 1) / (total + 1) - passed / total.
            # This simplifies to (total - passed) / (total * (total + 1)).
            # If total == passed, the ratio is already 1.0, and adding a student won't increase it.
            # In this case, (total - passed) is 0, so the increase is 0.
            if total == 0: # Should not happen based on problem constraints (total >= 1)
                return 0.0
            return (total - passed) / (total * (total + 1))

        # Use a min-heap to store (-increase, passed, total) tuples.
        # We negate the increase because heapq is a min-heap, and we want to
        # extract the class with the maximum increase.
        pq = []
        for p, t in classes:
            increase = calculate_increase(p, t)
            heapq.heappush(pq, (-increase, p, t))

        # Distribute extra students
        for _ in range(extraStudents):
            # Pop the class that offers the largest potential increase
            neg_increase, p, t = heapq.heappop(pq)

            # Add one student to this class
            p += 1
            t += 1

            # Calculate the new potential increase for this updated class
            new_increase = calculate_increase(p, t)

            # Push the updated class back into the heap
            heapq.heappush(pq, (-new_increase, p, t))

        # Calculate the final average pass ratio
        total_ratio = 0.0
        num_classes = len(classes)

        for neg_increase, p, t in pq:
            total_ratio += p / t

        return total_ratio / num_classes