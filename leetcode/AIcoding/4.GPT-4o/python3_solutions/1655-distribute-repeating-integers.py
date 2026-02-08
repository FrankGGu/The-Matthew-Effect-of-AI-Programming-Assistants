def distributeRepeatingIntegers(nums, quantity):
    from collections import Counter
    from itertools import combinations

    count = Counter(nums)
    unique_nums = list(count.keys())
    max_combinations = []

    def backtrack(start, remaining):
        if remaining == 0:
            max_combinations.append(0)
            return 1

        total = 0
        for i in range(start, len(unique_nums)):
            if count[unique_nums[i]] > 0:
                count[unique_nums[i]] -= 1
                total += backtrack(i, remaining - 1)
                count[unique_nums[i]] += 1
        return total

    return backtrack(0, quantity)