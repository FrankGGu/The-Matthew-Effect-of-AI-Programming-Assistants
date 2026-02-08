import heapq

class Solution:
    def nextGreaterElements(self, nums: list[int]) -> list[int]:
        n = len(nums)
        ans = [-1] * n

        s1 = []  # Monotonic decreasing stack for finding the first greater element
                 # Stores indices i such that nums[i] is decreasing.

        s2_candidates = [] # Min-heap of (value, index) pairs.
                           # Stores elements (nums[i], i) that have found their first greater,
                           # and are now waiting for their second greater.
                           # The heap allows efficient retrieval of the smallest nums[i] among candidates.

        for j in range(n):
            num = nums[j]

            # Process s2_candidates to find second greater elements
            # If current num is greater than the smallest candidate in s2_candidates,
            # then num is the second greater for that candidate.
            while s2_candidates and s2_candidates[0][0] < num:
                val, idx = heapq.heappop(s2_candidates)
                ans[idx] = num

            # Process s1 to find first greater elements
            # If current num is greater than elements at the top of s1,
            # then num is the first greater for those elements.
            # These elements are then moved to s2_candidates.

            # Temporarily store elements popped from s1
            temp_s2_add = [] 
            while s1 and nums[s1[-1]] < num:
                idx = s1.pop()
                temp_s2_add.append((nums[idx], idx))

            # Push current index onto s1
            s1.append(j)

            # Add elements from temp_s2_add to s2_candidates (min-heap)
            for val, idx in temp_s2_add:
                heapq.heappush(s2_candidates, (val, idx))

        return ans