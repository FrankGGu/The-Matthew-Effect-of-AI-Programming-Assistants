class Solution:
    def minimizeConcatenatedLength(self, words: List[str]) -> int:
        n = len(words)
        if n == 0:
            return 0

        memo = {}

        def dfs(index, first_char, last_char):
            if index == n:
                return 0
            key = (index, first_char, last_char)
            if key in memo:
                return memo[key]

            current_word = words[index]
            current_first = current_word[0]
            current_last = current_word[-1]

            # Option 1: place current_word after the previous concatenation
            cost1 = dfs(index + 1, first_char, current_last)
            if last_char == current_first:
                cost1 -= 1

            # Option 2: place current_word before the previous concatenation
            cost2 = dfs(index + 1, current_first, last_char)
            if current_last == first_char:
                cost2 -= 1

            total_cost = len(current_word) + min(cost1, cost2)
            memo[key] = total_cost
            return total_cost

        initial_word = words[0]
        return len(initial_word) + dfs(1, initial_word[0], initial_word[-1])