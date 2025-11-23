class Solution:
    def minimumPossibleSum(self, n: int, target: int) -> int:
        current_sum = 0
        count = 0
        picked_numbers = set()
        num = 1

        while count < n:
            # Condition 3: If x is an element of the array, then target - x is not an element of the array.

            # Case 1: num * 2 == target
            # If num is picked, then target - num (which is num itself) must not be picked.
            # This leads to a contradiction (num is picked AND num is not picked),
            # so num cannot be picked if num * 2 == target.
            if num * 2 == target:
                num += 1
                continue

            # Case 2: target - num is already in picked_numbers.
            # If we pick num, then target - num (which is already in our array) would violate the condition.
            # Therefore, we cannot pick num.
            if (target - num) in picked_numbers:
                num += 1
                continue

            # If neither of the above conditions are met, we can safely pick num.
            # To minimize the sum, we greedily pick the smallest available valid positive integer.
            current_sum += num
            picked_numbers.add(num)
            count += 1
            num += 1

        return current_sum