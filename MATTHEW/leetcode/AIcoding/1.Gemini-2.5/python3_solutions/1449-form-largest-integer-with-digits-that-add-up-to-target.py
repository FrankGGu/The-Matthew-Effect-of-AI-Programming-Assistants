class Solution:
    def largestNumber(self, cost: List[int], target: int) -> str:
        # dp[i] will store the largest number (as a string) that can be formed
        # with a total cost of i.
        # Initialize with "-1" to signify that no number can be formed for that cost yet.
        dp = ["-1"] * (target + 1)

        # Base case: A cost of 0 can form an empty string (no digits).
        dp[0] = ""

        # Iterate through all possible costs from 1 to target
        for i in range(1, target + 1):
            # Iterate through each digit from 1 to 9
            # cost[j] corresponds to the cost of digit (j+1)
            for j in range(9): 
                c = cost[j]
                digit = str(j + 1)

                # Check if we can form a number for cost (i - c)
                # and if adding the current digit 'digit' is possible
                if i - c >= 0 and dp[i - c] != "-1":
                    candidate = dp[i - c] + digit

                    # If dp[i] is currently impossible ("-1") or
                    # if the candidate number is longer than the current best for dp[i]
                    if dp[i] == "-1" or len(candidate) > len(dp[i]):
                        dp[i] = candidate
                    # If the candidate number has the same length as the current best for dp[i]
                    # and is lexicographically greater
                    elif len(candidate) == len(dp[i]):
                        if candidate > dp[i]:
                            dp[i] = candidate

        # After filling the DP table, dp[target] will hold the result.
        # If dp[target] is still "-1", it means no such number can be formed, so return "0".
        # Otherwise, return the formed number.
        return dp[target] if dp[target] != "-1" else "0"