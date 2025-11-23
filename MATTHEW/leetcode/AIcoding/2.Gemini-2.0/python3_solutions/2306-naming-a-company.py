from collections import defaultdict

class Solution:
    def distinctNames(self, ideas: list[str]) -> int:
        initial_groups = defaultdict(set)
        for idea in ideas:
            initial_groups[idea[0]].add(idea[1:])

        total_names = 0
        initial_letters = list(initial_groups.keys())

        for i in range(len(initial_letters)):
            for j in range(i + 1, len(initial_letters)):
                letter1 = initial_letters[i]
                letter2 = initial_letters[j]
                set1 = initial_groups[letter1]
                set2 = initial_groups[letter2]
                common = len(set1.intersection(set2))
                unique1 = len(set1) - common
                unique2 = len(set2) - common
                total_names += unique1 * unique2 * 2

        return total_names