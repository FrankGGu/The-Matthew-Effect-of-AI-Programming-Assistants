import heapq

class Solution:
    def isPossible(self, target: list[int]) -> bool:
        n = len(target)

        # Handle the base case where n=1
        if n == 1:
            return target[0] == 1

        # Use a max-heap to efficiently get the largest element
        # Python's heapq is a min-heap, so store negative values
        pq = []
        current_sum = 0
        for x in target:
            # According to constraints, target[i] >= 1, but good to have a check
            if x < 1:
                return False
            heapq.heappush(pq, -x)
            current_sum += x

        # The process is to work backwards from target to an array of all ones.
        # In each step, we take the largest element M, and reverse the operation.
        # The operation is: replace an element x with the sum of the array S_old.
        # So, M = S_old.
        # The current sum S = (S_old - x_prev) + M, where x_prev is the element M replaced.
        # Substituting S_old = M, we get S = (M - x_prev) + M => x_prev = 2 * M - S.
        # This x_prev is the value that M had before it was replaced.

        # Loop while the maximum element in the heap is greater than 1
        while -pq[0] > 1:
            max_val = -heapq.heappop(pq)

            # The sum of elements other than max_val
            other_elements_sum = current_sum - max_val

            # Critical checks for impossibility:
            # 1. If other_elements_sum is 0, it means n=1.
            #    Since max_val > 1 (loop condition), it's impossible to reduce it further.
            #    (This case is mostly covered by the initial n=1 check, but acts as a safeguard)
            if other_elements_sum == 0:
                return False

            # 2. If max_val is less than or equal to other_elements_sum, it's impossible.
            #    If max_val == other_elements_sum, then prev_val would be 0 or max_val itself, leading to infinite loop or invalid state.
            #    If max_val < other_elements_sum, then max_val could not have been formed by replacing a positive element.
            #    The previous value (prev_val) must be at least 1.
            #    If max_val <= other_elements_sum, then max_val - k * other_elements_sum will be <= 0 for k >= 1.
            if max_val <= other_elements_sum:
                return False

            # Calculate the previous value of max_val using the optimized modulo approach.
            # This handles multiple reverse steps at once.
            # prev_val = max_val - k * other_elements_sum, where k is chosen such that 1 <= prev_val < other_elements_sum.
            prev_val = max_val % other_elements_sum

            # If prev_val is 0, it means max_val was a multiple of other_elements_sum.
            # In this case, the previous value should be other_elements_sum itself (not 0).
            # Example: [6,3], S=9, M=6, other_sum=3. 6%3=0. prev_val should be 3.
            if prev_val == 0:
                prev_val = other_elements_sum

            # Update the total sum for the next iteration
            current_sum = current_sum - max_val + prev_val

            # Push the previous value back to the heap
            heapq.heappush(pq, -prev_val)

        # If the loop finishes, it means all elements in the heap are 1 (or less, but they must be 1 for a valid path).
        # Since we check for prev_val >= 1 and max_val <= other_elements_sum, we ensure positivity.
        return True