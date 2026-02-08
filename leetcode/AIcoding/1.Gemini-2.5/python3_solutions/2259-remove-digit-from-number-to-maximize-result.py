class Solution:
    def removeDigit(self, number: str, digit: str) -> str:
        possible_results = []
        n = len(number)

        for i in range(n):
            if number[i] == digit:
                # Remove the digit at index i
                result_num = number[:i] + number[i+1:]
                possible_results.append(result_num)

        # Return the maximum number lexicographically
        return max(possible_results)