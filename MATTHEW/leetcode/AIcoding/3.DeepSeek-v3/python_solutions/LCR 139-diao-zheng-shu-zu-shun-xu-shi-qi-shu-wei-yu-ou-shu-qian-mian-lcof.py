class Solution:
    def trainingPlan(self, actions: List[int]) -> List[int]:
        left, right = 0, len(actions) - 1
        while left < right:
            while left < right and actions[left] % 2 == 1:
                left += 1
            while left < right and actions[right] % 2 == 0:
                right -= 1
            actions[left], actions[right] = actions[right], actions[left]
        return actions