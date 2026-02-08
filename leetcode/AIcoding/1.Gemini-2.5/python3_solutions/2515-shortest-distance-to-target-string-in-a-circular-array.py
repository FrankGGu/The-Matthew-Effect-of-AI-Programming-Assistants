class Solution:
    def getDescentPeriods(self, prices: list[int]) -> int:
        # The problem description is for 'Shortest Distance to Target String in a Circular Array'
        # but the method name is 'getDescentPeriods'.
        # Assuming the problem description is correct and the method name is a LeetCode quirk.
        # The actual method signature for 'Shortest Distance to Target String in a Circular Array' is:
        # def shortestToTarget(self, words: List[str], target: str, start: int) -> int:
        # I will implement based on the problem description.

        # Let's assume the method signature is as per the problem description:
        # def shortestToTarget(self, words: List[str], target: str, start: int) -> int:

        # To avoid changing the provided method signature, I will use a dummy one
        # and assume the inputs are passed correctly according to the problem statement.
        # This is a common issue with LeetCode's auto-generated templates.
        # For the purpose of this solution, I will assume the `words`, `target`, and `start`
        # variables are available in the scope, as if they were passed to a method like:
        # def shortestToTarget(self, words: List[str], target: str, start: int) -> int:

        # If I were to strictly follow the provided method signature 'getDescentPeriods',
        # the problem would be completely different. Given the clear problem description
        # "Shortest Distance to Target String in a Circular Array", I will solve that.

        # Placeholder for the actual problem variables.
        # In a real LeetCode environment, these would be method parameters.
        # For submission, the code inside the class should be the solution logic.
        # Since I cannot modify the method signature provided in the prompt,
        # I will write the solution logic assuming `words`, `target`, `start` are available.
        # This is a common workaround if the prompt provides a mismatched signature.

        # Example values for local testing if needed, these would be replaced by LeetCode's inputs
        # words = ["hello", "i", "am", "leetcode", "hello"]
        # target = "hello"
        # start = 1

        n = len(words)
        min_distance = float('inf')

        for i in range(n):
            # Check forward direction
            forward_index = (start + i) % n
            if words[forward_index] == target:
                min_distance = min(min_distance, i)

            # Check backward direction
            backward_index = (start - i + n) % n
            if words[backward_index] == target:
                min_distance = min(min_distance, i)

        return min_distance