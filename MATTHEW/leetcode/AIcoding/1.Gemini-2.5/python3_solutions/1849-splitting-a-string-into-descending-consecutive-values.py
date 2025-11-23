class Solution:
    def splitString(self, s: str) -> bool:
        n = len(s)

        def dfs(index, prev_val, num_parts_count):
            # Base case: If we have reached the end of the string.
            # A valid split requires at least two numbers.
            if index == n:
                return num_parts_count >= 2

            # Iterate through possible end points for the current number.
            # The current number will be s[index : i+1].
            for i in range(index, n):
                current_str = s[index : i + 1]
                current_val = int(current_str)

                # Case 1: This is the first number being parsed.
                # We don't have a previous value to compare against.
                if num_parts_count == 0:
                    # Recursively call for the rest of the string,
                    # setting current_val as the new previous value and incrementing count.
                    if dfs(i + 1, current_val, 1):
                        return True
                # Case 2: This is a subsequent number.
                # We need to compare it with the previous number.
                else:
                    # Check if current_val is exactly one less than prev_val.
                    if current_val == prev_val - 1:
                        # If it is, recurse.
                        if dfs(i + 1, current_val, num_parts_count + 1):
                            return True

                    # Pruning: If the current number is already greater than
                    # what it should be (prev_val - 1), then any longer number
                    # formed by extending current_str from this 'index' will be
                    # even larger. So, there's no point in trying longer substrings
                    # from this 'index'. We can stop this branch of exploration.
                    if current_val > prev_val - 1:
                        break 

            # If no valid split was found from this 'index' and 'prev_val' combination.
            return False

        # Start the DFS from the beginning of the string (index 0).
        # We use -1 as a placeholder for prev_val when num_parts_count is 0,
        # as it will not be used in comparisons until num_parts_count > 0.
        return dfs(0, -1, 0)