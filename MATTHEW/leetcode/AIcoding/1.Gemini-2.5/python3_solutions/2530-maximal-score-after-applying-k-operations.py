import heapq

class Solution:
    def maxResult(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # dp[i] will store the maximum score to reach index i.
        # We don't need to store the full dp array, only the scores in the sliding window.
        # max_heap will store tuples (-score, index) to efficiently query the maximum score
        # in the window [i-k, i-1].
        max_heap = [] 

        # Base case: To reach index 0, the score is nums[0].
        # Push (-nums[0], 0) to the max_heap.
        heapq.heappush(max_heap, (-nums[0], 0))

        # current_score will store dp[i] for the current index i.
        current_score = nums[0]

        # Iterate from the second element to the last element.
        for i in range(1, n):
            # Remove elements from the heap that are outside the sliding window [i-k, i-1].
            # The indices in the heap are from previous steps. If an index j is less than i-k,
            # it means it's too far to jump from to reach current index i.
            while max_heap and max_heap[0][1] < i - k:
                heapq.heappop(max_heap)

            # The top of the heap now contains the maximum score (negated) from the valid window.
            # max_prev_score = dp[j] for some j in [i-k, i-1] that maximizes dp[j].
            max_prev_score = -max_heap[0][0]

            # Calculate the current score to reach index i.
            current_score = nums[i] + max_prev_score

            # Push the current score and its index to the heap.
            heapq.heappush(max_heap, (-current_score, i))

        # The maximal score to reach the last index (n-1) is the final current_score.
        return current_score