import bisect

class Solution:
    def longestObstacleCourseAtEachPosition(self, obstacles: list[int]) -> list[int]:
        n = len(obstacles)
        ans = [0] * n

        # tails[i] stores the smallest ending element of a non-decreasing subsequence of length i+1.
        # This list will always be sorted in non-decreasing order.
        tails = [] 

        for i, obs in enumerate(obstacles):
            # Find the index 'j' where 'obs' can be inserted into 'tails'
            # such that 'tails' remains sorted and 'obs' is placed after 
            # all elements less than or equal to 'obs'.
            # This 'j' effectively represents the length of the new non-decreasing subsequence
            # if we consider 'tails' as a list of minimum ending values for subsequences of length (index+1).
            j = bisect.bisect_right(tails, obs)

            if j == len(tails):
                # If 'obs' is greater than or equal to all elements in 'tails',
                # it extends the longest non-decreasing subsequence found so far.
                # A new longest subsequence is formed.
                tails.append(obs)
            else:
                # If 'obs' is smaller than or equal to tails[j], it means we found a 
                # non-decreasing subsequence of length j+1 ending with 'obs'.
                # By replacing tails[j] with 'obs', we are maintaining the property
                # that tails[j] is the smallest ending element for a subsequence of length j+1.
                # This 'obs' is "better" (smaller or equal ending element) than the previous tails[j],
                # which allows for potentially longer sequences later.
                tails[j] = obs

            # The length of the longest non-decreasing subsequence ending at 'obstacles[i]'
            # is j+1 (because tails is 0-indexed, so an element at index 'j' corresponds to length j+1).
            ans[i] = j + 1

        return ans