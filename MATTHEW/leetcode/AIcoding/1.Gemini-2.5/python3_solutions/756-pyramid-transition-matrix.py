import collections

class Solution:
    def pyramidTransition(self, bottom: str, allowed: list[str]) -> bool:
        # Preprocess allowed for efficient lookup
        # transitions[(char1, char2)] = set of char3
        transitions = collections.defaultdict(set)
        for t in allowed:
            transitions[(t[0], t[1])].add(t[2])

        # Memoization dictionary to store results of dfs for already computed rows
        # memo[row_str] = True if pyramid can be built from row_str, False otherwise
        memo = {}

        # Main recursive function to check if a pyramid can be built starting from current_row_str
        def dfs(current_row_str: str) -> bool:
            # Base case: If the row has only one character, we successfully built the pyramid
            if len(current_row_str) == 1:
                return True

            # Check memoization table
            if current_row_str in memo:
                return memo[current_row_str]

            # This inner recursive function attempts to build the next row (next_row_list)
            # from the current_row_str, character by character.
            # It uses backtracking to try all possible combinations.
            # It returns True as soon as it finds a valid next_row_list that leads to a complete pyramid.
            def generate_next_rows(idx: int, built_next_row_list: list[str]) -> bool:
                # Base case for building a single next_row:
                # If we have processed all adjacent pairs in current_row_str,
                # then a complete next_row_list has been formed.
                if idx == len(current_row_str) - 1:
                    # Convert the list of characters to a string for the next row
                    next_row_str = "".join(built_next_row_list)
                    # Recursively call dfs for the newly formed next row
                    if dfs(next_row_str):
                        return True # This next_row_str leads to a solution
                    return False # This specific next_row_str did not lead to a solution

                # Recursive step: Consider the current adjacent pair
                char1 = current_row_str[idx]
                char2 = current_row_str[idx + 1]

                # Get all possible characters that can be placed above this pair
                possible_chars_above = transitions.get((char1, char2), set())

                # If no character can be placed above this pair, this path is invalid
                if not possible_chars_above:
                    return False

                # Try each possible character above the current pair
                for char_above in possible_chars_above:
                    built_next_row_list.append(char_above) # Add character to the next row
                    # Recursively try to build the rest of the next row
                    if generate_next_rows(idx + 1, built_next_row_list):
                        return True # Found a path to a solution
                    built_next_row_list.pop() # Backtrack: remove character to try another option

                return False # No character above this pair led to a solution

            # Start the process of generating the next row from the current_row_str
            result = generate_next_rows(0, [])

            # Store the result in memo before returning
            memo[current_row_str] = result
            return result

        # Start the pyramid building process from the initial bottom row
        return dfs(bottom)